require "rails_helper"

RSpec.describe "Search By Top Voted", type: :feature do
  describe "As a User" do
    #story 1
    it "has a button to discover top rated movies and a search field" do
      user = User.create!(name: 'Tommy', email: 'tommy@email.com')

      # When I visit the '/users/:id/discover' path (where :id is the id of a valid user),
      visit user_discover_index_path(user)
      # I should see
      # - a Button to Discover Top Rated Movies
      expect(page).to have_button("Discover Top Rated Movies")
      # - a text field to enter keyword(s) to search by movie title
      expect(page).to have_field(:movie_title)
      # - a Button to Search by Movie Title
      expect(page).to have_button("Search")
    end

    it "takes user to users/:user_id/movies page" do 
      json_response = File.read("spec/fixtures/top_voted_movies/tmdb_top_voted_movies.json")
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=4c5a041db10b9e21e2c9287447a724f4&include_adult=false&language=en-US&page=1&query=").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:key]
          }
        ).
        to_return(status: 200, body: json_response)

      user = User.create!(name: 'Tommy', email: 'tommy@email.com')

      visit user_discover_index_path(user)
    
      click_on("Discover Top Rated Movies")
      
      expect(current_path).to eq(user_movies_path(user))
      expect(page).to have_css(".movie_title")
      expect(page).to have_css(".vote_average")
    end
  end 
end