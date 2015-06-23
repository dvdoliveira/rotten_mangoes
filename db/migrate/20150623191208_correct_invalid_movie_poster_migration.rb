class CorrectInvalidMoviePosterMigration < ActiveRecord::Migration
  def change
    remove_column :users, :movie_poster
    add_column :movies, :movie_poster, :string
  end
end
