class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = MovieSearchFacade.new(params[:search])
  end
end