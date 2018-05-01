class SearchController < ApplicationController

  def index
    @members = Member.find_all(params[:state])
  end



end
