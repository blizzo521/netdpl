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

    dpl = DPL.new(@current_user)

    @netdplapp_props = {
      user: {
        email: @current_user.email,
        name: dpl.name,
      },
      books: dpl.books,
      loans: dpl.loans,
      holds: dpl.holds,
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
