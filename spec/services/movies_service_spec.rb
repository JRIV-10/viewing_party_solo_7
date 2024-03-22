require "rails_helper"

RSpec.describe MoviesService do 

  describe "#top_voted_movies" do 
    it "can find top voted movies" do 
      json_stub("spec/fixtures/top_voted_movies/tmdb_top_voted_movies.json", "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc")
      
      top_movies = MoviesService.new 

      expect(top_movies.top_voted_movies).to be_a(Hash)
      expect(top_movies.top_voted_movies[:results]).to be_an Array

      movie_data = top_movies.top_voted_movies[:results].first
      
      expect(movie_data).to have_key :title
      expect(movie_data[:title]).to be_a(String)

      expect(movie_data).to have_key :vote_average
      expect(movie_data[:vote_average]).to be_a(Float)

      expect(movie_data).to have_key :id
      expect(movie_data[:id]).to be_a(Integer)
    end
  end

  describe "#search_by_title(keyword)" do 
    it "can find keywords in search for a movie" do 
      json_stub("spec/fixtures/key_word_search/tmdb_kung_fu_panda.json", "https://api.themoviedb.org/3/search/movie?include_adult=false&language=en-US&page=1&query=Kung%20Fu%20Panda")

      search = MoviesService.new.search_by_title("Kung Fu Panda")

      expect(search).to be_a(Hash)
      expect(search[:results]).to be_a(Array)

      search_data = search[:results].first 

      expect(search_data).to have_key :title
      expect(search_data[:title]).to be_a(String)

      expect(search_data).to have_key :vote_average
      expect(search_data[:vote_average]).to be_a(Float)
    end
  end

  describe "#get_url(url)" do 
    it "can get a url" do 
      json_stub("spec/fixtures/top_voted_movies/tmdb_top_voted_movies.json", "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc")

      service = MoviesService.new 

      expect(service.get_url("/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc")).to be_a(Hash)
      expect(service.get_url("/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc")[:results].first).to have_key :title
      expect(service.get_url("/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc")[:results].first).to have_key :vote_average
    end
  end
  
  describe "#conn" do 
    it "provides a connection to the api" do 
      service = MovieService.new 

      expect(service.conn).to be_a(Faraday::Connection)
    end
  end
end