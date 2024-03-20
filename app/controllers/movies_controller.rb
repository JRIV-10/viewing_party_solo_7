class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmdb[:key]
    end
    
    response = conn.get("/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc")
    json = JSON.parse(response.body, symbolize_names: true)
  end
end