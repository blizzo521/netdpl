class DashboardController < ApplicationController
  layout 'dashboard'
  before_action :ensure_logged_in

  def index






    @netdplapp_props = {
      user: {
        email: @current_user.email
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
