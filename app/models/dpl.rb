require 'rubygems'
require 'mechanize'
require 'pry-remote'

class DPL
  def initialize(user)
    @user = user
    @agent = Mechanize.new { |agent|
      agent.follow_meta_refresh = true
      agent.user_agent_alias = 'Mac Firefox'
    }
  end

  def search(keywords)
    authenticate
    results = []

    @agent.get("https://catalog.denverlibrary.org/search/components/ajaxResults.aspx?page=1&type=Keyword&term=#{params[:keyword]}&by=KW&sort=RELEVANCE&limit=TOM=*&query=&page=0&searchid=5") do |search_page|
      form = search_page.form_with(:action => 'https://catalog.denverlibrary.org/search/default.aspx')
https://catalog.denverlibrary.org/search/components/ajaxResults.aspx?page=1&type=Keyword&term=gwenpool&by=KW&sort=RELEVANCE

      binding.remote_pry


      form['ctrlSearchBars:searchbarKeyword:textboxTerm'] = keywords

      results_page = form.submit(form.buttons.first)

    end
  end

  def holds
    load_initial_data unless @holds
    @holds
  end

  def books
    load_initial_data unless @books
    @books
  end

  def name
    load_initial_data unless @name
    @name
  end

  def loans
    load_initial_data unless @loans
    @loans
  end

  private

  def authenticate
    return if @authenticated

    @agent.get('https://catalog.denverlibrary.org/logon.aspx') do |signin_page|
      form = signin_page.form_with(:action => './logon.aspx')
      form.textboxBarcodeUsername  = @user.dpl_username
      form.textboxPassword = @user.dpl_password

      my_page = form.submit(form.buttons.first)
      @authenticated = my_page.uri.to_s.match? /patronaccount/
    end
    raise 'Authentication error' unless @authenticated
  end

  def load_initial_data
    authenticate

    @name = ''
    @loans = []
    @books = []
    @holds = []

    @agent.get('https://catalog.denverlibrary.org/patronaccount/') do |my_page|
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
