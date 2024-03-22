require "rails_helper"

RSpec.describe MovieFacade do
  describe "#self.movie" do 
    it "can a movie by the id" do 
      json_response = File.read("spec/fixtures/movie_details/tmdb_kung_fu_panda_4.json")
      stub_request(:get, "https://api.themoviedb.org/3/movie/1011985").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:key]
          }
        ).
        to_return(status: 200, body: json_response)


        expect(MovieFacade.movie(1011985)).to be_a(Movie)
        expect(MovieFacade.movie(1011985).title).to eq("Kung Fu Panda 4")
    end
  end

  describe "#self.cast_members(movie_id)" do 
    it "shows casts member of a movie" do 
      json_response_2 = File.read("spec/fixtures/movie_details/cast_members/tmdb_kung_fu_panda_4_cast.json")
        stub_request(:get, "https://api.themoviedb.org/3/movie/1011985/credits").
          with(
            query: {
              "api_key" => Rails.application.credentials.tmdb[:key]
            }
          ).
          to_return(status: 200, body: json_response_2)

      expect(MovieFacade.cast_members(1011985)).to be_a(Array)
      expect(MovieFacade.cast_members(1011985).first.name).to eq("Jack Black")
    end
  end

  describe "#self.total_reviews(movie_id)" do 
    it "shows reviews" do 
      json_response_3 = File.read("spec/fixtures/movie_details/reviews/tmdb_kung_fu_panda_4_review.json")
          stub_request(:get, "https://api.themoviedb.org/3/movie/1011985/reviews").
            with(
              query: {
                "api_key" => Rails.application.credentials.tmdb[:key]
              }
            ).
            to_return(status: 200, body: json_response_3)
      
      expect(MovieFacade.total_reviews(1011985)).to be_a(Array)
      expect(MovieFacade.total_reviews(1011985).first.author).to eq("Chris Sawin")
    end
  end
end