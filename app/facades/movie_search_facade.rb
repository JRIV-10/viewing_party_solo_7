class MovieSearchFacade

  def initialize(search_params)
    @search_params = search_params
  end

  def movies
    service = MoviesService.new
    if @search_params == "top_rated"
          json = service.top_voted_movies
          movies = json[:results].map do |movie_data|
            Movie.new(movie_data)
          end
    else 
      json = service.search_by_title(@search_params)
      movies = json[:results].map do |movie_data|
        Movie.new(movie_data)
      end
    end
  end
end