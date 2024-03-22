class MoviesService 
  
  def top_voted_movies
    get_url("/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc")
  end

  def search_by_title(key_word)
    get_url("/3/search/movie?query=#{key_word}&include_adult=false&language=en-US&page=1")
  end

  def get_url(url) 
    response = conn.get(url)

    json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn 
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmdb[:key]
    end
  end
end