class SearchController < ApplicationController
  layout :none
  before_action :ensure_logged_in

  def index
    results = []
    resultCount = 1 + rand(6)
    (0..resultCount).each do |i|
      result = {}
      result['title'] = (0...15).map{('a'..'z').to_a[rand(26)] }.join
      results << result
    end

    dpl = DPL.new(@current_user)
    dpl.search(params[:keywords])

    render json: results
  end

  private

  def ensure_logged_in
    unless logged_in?
      raise "OH NO"
    end
  end
end
