class SearchController < ApplicationController
  layout :none
  before_action :ensure_logged_in

  def index
    dpl = DPL.new(@current_user)
    render json: dpl.search(params[:keywords])
  end

  private

  def ensure_logged_in
    unless logged_in?
      raise "OH NO"
    end
  end
end
