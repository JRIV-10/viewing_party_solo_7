class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = MovieSearchFacade.new(params[:search])
  end

  def show
    movie_id = params[:id]
    @user = User.find(params[:user_id])
    @movie = MovieFacade.movie(movie_id)
    @cast = MovieFacade.cast_members(movie_id)
    @review = MovieFacade.total_reviews(movie_id)
  end
end