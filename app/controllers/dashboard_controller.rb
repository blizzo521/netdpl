require 'rubygems'
require 'mechanize'
require 'pry-remote'

class DashboardController < ApplicationController
  layout 'dashboard'
  before_action :ensure_logged_in

  def index
    my_page = nil
    signin_page = nil
    loans_page = nil
    loans = []

    name = ''
    a = Mechanize.new { |agent|
      agent.follow_meta_refresh = true
      agent.user_agent_alias = 'Mac Firefox'
    }

    a.get('https://catalog.denverlibrary.org/logon.aspx') do |signin|
      signin_page = signin

      form = signin_page.form_with(:action => './logon.aspx')
      form.textboxBarcodeUsername  = @current_user.dpl_username
      form.textboxPassword = @current_user.dpl_password

      my_page = form.submit(form.buttons.first)

      name = my_page.search('#ctrlBasicInfo_labelPatron').text
      name = name.split(', ').reverse.join(' ').split(' ').map(&:capitalize).join(' ')

      loans_page = my_page.links.find { |l| l.text.match(/items out/i)}.click

      loan_rows = loans_page.search('.patrongrid-row, .patrongrid-alternating-row')
      loan_rows.each do |loan|
        type = loan.search('td:nth-child(3) img').first['alt']
        title = loan.search('td:nth-child(5)').text.strip
        due = loan.search('td:nth-child(7)').text.strip
        renewals = loan.search('td:nth-child(8)').text.strip

        loans << {type: type, title: title, due: due, renewals: renewals}
      end
    end

    @netdplapp_props = {
      user: {
        email: @current_user.email,
        name: name,
      },
      books: [{id: 5}],
      loans: loans,
      holds: [{id: 1}],
    }
  end

  private

  def logit(label, thing)
    puts "############## #{label} ###############"
    puts thing.class
    if thing.is_a? Mechanize::Page
      puts thing.uri
    else
      puts thing
    end
  end

  def ensure_logged_in
    unless logged_in?
      raise "OH NO"
    end
  end
end
