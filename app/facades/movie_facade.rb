class MovieFacade

  def self.movie(movie_id) 
    service = MovieService.new 
    json = service.movie_details(movie_id)
    Movie.new(json)
  end

  def self.cast_members(movie_id)
    service = MovieService.new 
    json = service.cast_members(movie_id)
    json[:cast].take(10).map do |cast_member|
      CastMember.new(cast_member)
    end
  end

  def self.total_reviews(movie_id)
    service = MovieService.new 
    json = service.all_reviews(movie_id)
    json[:results].map do |review|
      MovieReview.new(review)
    end
  end
end