require "rails_helper"

RSpec.describe Movie do 
  describe "initialize" do 
    it "exists" do 
      attrs = {
        title: "Good Luck Chuck",
        vote_average: "12"
        }

      movie = Movie.new(attrs)

      expect(movie.title).to eq("Good Luck Chuck")
      expect(movie.vote_average).to eq("12")
    end
  end
end