require "rails_helper"

RSpec.describe MovieSearchFacade do
  describe "#initialize" do 
    it "exists" do 
      facade = MovieSearchFacade.new("Top Rated Movies")

      expect(facade).to be_a(MovieSearchFacade)
    end
  end

  describe "#movies" do 
    it "can search for top voted movies and call the correct api end point" do 
      json_response = File.read("spec/fixtures/top_voted_movies/tmdb_top_voted_movies.json")
      stub_request(:get, "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:key]
          }
        ).
        to_return(status: 200, body: json_response)

      facade = MovieSearchFacade.new("top_rated")

      expect(facade.movies.all?(Movie)).to eq(true)
    end

    it "can search movies based off keywords" do 
      json_response = File.read("spec/fixtures/key_word_search/tmdb_kung_fu_panda.json")
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?include_adult=false&language=en-US&page=1&query=Kung%20Fu%20Panda").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:key]
          }
        ).
        to_return(status: 200, body: json_response)

      facade = MovieSearchFacade.new("Kung Fu Panda")

      expect(facade.movies.all?(Movie)).to eq(true)
    end
  end
end