require 'rubygems'
require 'mechanize'
require 'pry-remote'

class DPL
  attr_reader :holds, :books, :name, :loans

  def initialize(user)
    # Instance variables
    @user = user
    @name = ''
    @loans = []
    @books = []
    @holds = []
    @agent = Mechanize.new { |agent|
      agent.follow_meta_refresh = true
      agent.user_agent_alias = 'Mac Firefox'
    }

    load_initial_data
  end

  private

  def load_initial_data
    @agent.get('https://catalog.denverlibrary.org/logon.aspx') do |signin|
      signin_page = signin

      form = signin_page.form_with(:action => './logon.aspx')
      form.textboxBarcodeUsername  = @user.dpl_username
      form.textboxPassword = @user.dpl_password

      my_page = form.submit(form.buttons.first)

      @name = my_page.search('#ctrlBasicInfo_labelPatron').text
      @name = @name.split(', ').reverse.join(' ').split(' ').map(&:capitalize).join(' ')

      loans_page = my_page.links.find { |l| l.text.match(/items out/i)}.click

      loan_rows = loans_page.search('.patrongrid-row, .patrongrid-alternating-row')
      loan_rows.each do |loan|
        type = loan.search('td:nth-child(3) img').first['alt']
        title = loan.search('td:nth-child(5)').text.strip
        due = loan.search('td:nth-child(7)').text.strip
        renewals = loan.search('td:nth-child(8)').text.strip

        @loans << {type: type, title: title, due: due, renewals: renewals}
      end
    end
  end
end
