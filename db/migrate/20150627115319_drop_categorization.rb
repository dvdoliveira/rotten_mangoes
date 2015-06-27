class DropCategorization < ActiveRecord::Migration
  def change
    drop_table :categorization
  end
end
