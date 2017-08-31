require 'rubygems'
require 'mechanize'

class DashboardController < ApplicationController
  layout 'dashboard'
  before_action :ensure_logged_in

  def index
    my_page = nil
    signin_page = nil
    loans_page = nil

    name = ''
    a = Mechanize.new
    a.user_agent_alias = 'Mac Firefox'

    a.get('https://catalog.denverlibrary.org/logon.aspx') do |signin|
      puts "############## signin page ###############"
      puts signin_page
      signin_page = signin

      my_page = signin_page.form_with(:id => 'formMain') do |form|
        puts "############## form ###############"
        puts form
        form.textboxBarcodeUsername  = @current_user.dpl_username
        form.textboxPassword = @current_user.dpl_password
      end.submit

      puts "############## my page ###############"
      puts my_page

      name = my_page.search('div#main b').text

      loans_page = my_page.links.find { |l| l.text.match(/items out/i)}.click


      puts "############## loans page ###############"
      puts loans_page


      loan_rows = loans_page.search('.patrongrid-row, .patrongrid-alternating-row')
      pp loan_rows
    end




    @netdplapp_props = {
      user: {
        email: @current_user.email,
        name: name,
      },
      books: [{id: 5}],
      loans: [{id: 2}],
      holds: [{id: 1}],
    }
  end

  private

  def ensure_logged_in
    unless logged_in?
      raise "OH NO"
    end
  end
end
