require "rails_helper"

RSpec.describe "Search By Title", type: :feature do
  describe "As a User" do
    it "can search by title" do
      json_response = File.read("spec/fixtures/key_word_search/tmdb_kung_fu_panda.json")
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=4c5a041db10b9e21e2c9287447a724f4&include_adult=false&language=en-US&page=1&query=").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:key]
          }
        ).
        to_return(status: 200, body: json_response)

      user = User.create!(name: 'Tommy', email: 'tommy@email.com')
      visit user_discover_index_path(user)

      fill_in(:movie_title, with: "Kung Fu Panda")
      click_on("Search")

      expect(current_path).to eq(user_movies_path(user))
      expect(page).to have_css(".movie_title")
      expect(page).to have_css(".vote_average")
      expect(page).to have_button("Discover Page")
    end 
  end
end