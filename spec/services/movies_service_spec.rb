require "rails_helper"

RSpec.describe MoviesService do 

  describe "#top_voted_movies" do 
    xit "can find top voted movies" do 
      top_movies = MovieService.new 

      expect(top_movies.top_voted_movies).to be_a(Hash)
    end
  end
  
  describe "#conn" do 
    it "provides a connection to the api" do 
      service = MovieService.new 

      expect(service.conn).to be_a(Faraday::Connection)
    end
  end
end