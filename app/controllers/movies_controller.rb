class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    unless params.has_key?(:ratings) || params.has_key?(:order)
        @params = session.has_key?(:filters) ? session[:filters] : {:order=>:id}
        redirect_to movies_order_path(:order => @params[:order], :ratings => @params[:ratings]) if @params.any?
    else
        @params = params
        session[:filters] = @params
    end
    @movies = Movie.rating_in(params[:ratings]).order_by(params[:order])
    @all_ratings = Movie.all_ratings
  end


  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
