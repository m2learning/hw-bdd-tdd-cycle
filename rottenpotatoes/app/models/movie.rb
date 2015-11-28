class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.with_same_director(id)
    movie = Movie.find id
    return nil if (movie.director == nil || movie.director == "")
    Movie.where(director: movie.director)
  end


end
