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
      facade = MovieSearchFacade.new("top_rated")

      VCR.use_cassette("/Index/As_a_User/takes_user_to_users/_user_id/movies_page.yml") do 
        expect(facade.movies.all?(Movie)).to eq(true)
      end
    end

    it "can search movies based off keywords", :vcr do 
      facade = MovieSearchFacade.new("Six")

      expect(facade.movies.all?(Movie)).to eq(true)
    end
  end
end