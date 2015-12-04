require 'rails_helper'

describe 'MovieModel' do
  fixtures :movies

  describe 'getting the list of all movie ratings' do
    it 'shoudl return the list of all movie ratings' do 
       @all_ratings = Movie.all_ratings
       expect(@all_ratings).to eq(%w(G PG PG-13 NC-17 R))
    end
  end

  describe 'searching movies with same director' do
    it 'should find the movies with the same directors as movie id 1' do
      @movies = Movie.with_same_director(1)
      expect(@movies.length).to eq(2)
    end

    it 'should not find any movie with the same directors as movie id 3' do
      @movies = Movie.with_same_director(3)
      expect(@movies).to eq(nil)
    end
  end

  describe 'searching movie with where clause' do
    it 'should find the movies with the specified rating' do
      @ordering =  {:release_date => :asc}
      @all_ratings = Movie.all_ratings
      @movies = Movie.where(rating: @all_ratings).order(@ordering)
      expect(@movies.length).to eq(4)
    end
  end

end
