class AddPosterImageToMovies < ActiveRecord::Migration
  def change
    add_column :users, :movie_poster, :string
  end
end
