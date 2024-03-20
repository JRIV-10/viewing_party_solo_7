require "rails_helper"

RSpec.describe "Index", type: :feature do
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

    it "takes user to users/:user_id/movies page", :vcr do 
      user = User.create!(name: 'Tommy', email: 'tommy@email.com')

      visit user_discover_index_path(user)
      
      click_on("Discover Top Rated Movies")
 
      expect(current_path).to eq(user_movies_path(user))
    end
  end 
end