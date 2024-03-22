require "rails_helper"

RSpec.describe "Details Of Movie", type: :feature do
  describe "As a User" do
    before do 
      json_response = File.read("spec/fixtures/movie_details/tmdb_kung_fu_panda_4.json")
      stub_request(:get, "https://api.themoviedb.org/3/movie/1011985").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:key]
          }
        ).
        to_return(status: 200, body: json_response)

        json_response_2 = File.read("spec/fixtures/movie_details/cast_members/tmdb_kung_fu_panda_4_cast.json")
        stub_request(:get, "https://api.themoviedb.org/3/movie/1011985/credits").
          with(
            query: {
              "api_key" => Rails.application.credentials.tmdb[:key]
            }
          ).
          to_return(status: 200, body: json_response_2)

          json_response_3 = File.read("spec/fixtures/movie_details/reviews/tmdb_kung_fu_panda_4_review.json")
          stub_request(:get, "https://api.themoviedb.org/3/movie/1011985/reviews").
            with(
              query: {
                "api_key" => Rails.application.credentials.tmdb[:key]
              }
            ).
            to_return(status: 200, body: json_response_3)
    end

    it "displays title, vote average, runtime, genre, summary, cast members, review count, review author % info" do 
      user = User.create!(name: 'Tommy', email: 'tommy@email.com')
      
      visit user_movie_path(user, id: 1011985)
      
      expect(page).to have_button("Discover Page")
      expect(page).to have_button("Create a Viewing Party")
      expect(page).to have_content("Kung Fu Panda")
      expect(page).to have_content("6.912")
      expect(page).to have_content("1h 34m")
      expect(page).to have_content("Action, Adventure, Animation, Comedy, Family")
      expect(page).to have_content("Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.")
      expect(page).to have_content("Jack Black as Po")
      expect(page).to have_content("Number of Reviews: 1")
      expect(page).to have_content("Author Name: Chris Sawin")
      expect(page).to have_content("Review: _Kung Fu Panda 4_ isn’t the best _Kung Fu Panda_ film, or even the best of the series’ three sequels. However, as a fourth film in a franchise, it’s a ton of fun")
    end
  end 
end