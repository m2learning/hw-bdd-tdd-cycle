require 'rails_helper'

describe MoviesController do
  fixtures :movies

  describe 'searching movies with same director' do
    it 'should call the model method that performs the search of movies with the same director of the current movie' do
      Movie.should_receive(:with_same_director).with('1')
      get :with_same_director, {:id => 1}
    end

    it 'should select the with_same_director view for rendering' do
      #Movie.stub(:with_same_director)
      get :with_same_director, {:id => 1}
      response.should render_template('with_same_director')
    end    

    it 'should redirect to the home page if no director' do
      #Movie.stub(:with_same_director)
      get :with_same_director, {:id => 3}
      response.should redirect_to('/movies')
    end

    it 'should make the with_same_director search results available to the view' do
      fake_results = [double('Movie'), double('Movie')]
      Movie.stub(:with_same_director).and_return(fake_results)
      get :with_same_director, {:id => 1}
      # look for controller method to assign @movies
      assigns(:movies_with_same_director).should == fake_results
    end

  end

end
