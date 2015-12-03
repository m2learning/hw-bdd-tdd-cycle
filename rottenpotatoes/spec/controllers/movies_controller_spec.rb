require 'rails_helper'

describe MoviesController do
  fixtures :movies

  describe 'showing a specific movie with a given id' do
    it 'should call the model method that perform the search of movies by id' do
      Movie.should_receive(:find).with('1')
      get :show, {id: 1}
    end

    it 'should select the show view for rendering' do
      get :show, {id: 1}
      response.should render_template('show')
    end
  end

  describe 'showing the home page with the index filtered and sorted' do
    it 'should call the all_ratings method of the model' do
      Movie.should_receive(:all_ratings)
      get :index, {sort: 'title', ratings: ['R', 'G']}
    end

    it 'should redirect to restful url' do
      get :index, {sort: 'release_date', ratings: ['R', 'G']}
      response.should redirect_to('/movies?ratings%5B%5D=R&ratings%5B%5D=G&sort=release_date')
    end

  end


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


  describe 'Getting the new form' do
    it 'should render the new form' do
      get :new, {}
      response.should render_template('new')
    end
  end


  describe 'posting the create form' do
    it 'should call the create! method of the model' do
#      Movie.should_receive(:create!)
#      post :create, movie: {title: 'My New Movie', ratings: ['R', 'G'], release_date: '1984-10-26 00:00:00 UTC'}
    end

    it "creates a new movie" do
      expect{
        post :create, movie: {title: 'My New Movie', ratings: ['R', 'G'], release_date: '1984-10-26 00:00:00 UTC'}
      }.to change(Movie, :count).by(1)
    end

    it 'should redirect to the home page' do
      post :create, {movie: {title: 'My New Movie', ratings: ['R', 'G'], release_date: '1984-10-26 00:00:00 UTC'}}
      response.should redirect_to('/movies')
    end
  end

  describe 'PUT update' do
    it "redirects to the updated movie" do
      put :update, id: 1, movie: {title: 'My New Movie', ratings: ['R', 'G'], release_date: '1984-10-26 00:00:00 UTC'}
      response.should redirect_to('/movies/1')
    end    
  end


  describe 'DELETE destroy' do
    it "deletes the movie" do
      expect{
        delete :destroy, {id: 1} 
      }.to change(Movie, :count).by(-1)
    end
    
    it "redirects to movies#index" do
      delete :destroy, {id: 1} 
      response.should redirect_to('/movies')
    end
  end


end
