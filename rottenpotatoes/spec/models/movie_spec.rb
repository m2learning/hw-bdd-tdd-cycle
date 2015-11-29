require 'rails_helper'

describe 'MovieModel' do
  fixtures :movies

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
end
