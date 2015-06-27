class MoviesController < ApplicationController
  def index
    params['search'] ? @query = params['search']['query'] : @query = nil
    params['search'] ? @duration_a = params['search']['duration_a'] : @duration_a = nil
    params['search'] ? @duration_b = params['search']['duration_b'] : @duration_b = nil
    @movies = Movie.search(params[:search]).order(params[:order_by].to_s).page(params[:page]).per(5)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
    @all_genres = Genre.all
    @movie_genres = @movie.movie_genres.build
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    binding.pry
    params[:genres][:id].each do |genre|
      @movie.movie_genres.build(genre_id: genre)
    end

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :movie_poster, :remote_movie_poster_url, movie_genres_attributes: [ :id, :name] 
      )  
  end

end
