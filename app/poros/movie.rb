class Movie 
  attr_reader :title, 
              :vote_average,
              :id, 
              :run_time,
              :genres, 
              :summary

  def initialize(attributes) 
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @id = attributes[:id]
    @run_time = attributes[:runtime]
    @genres = attributes[:genres]
    @summary = attributes[:overview]
  end

  def format_run_time
    hours = @run_time / 60
    minutes = @run_time % 60
    "#{hours}h #{minutes}m"
  end

  def format_genres 
    @genres.map {|genre| genre[:name]}.join(", ")
  end
end