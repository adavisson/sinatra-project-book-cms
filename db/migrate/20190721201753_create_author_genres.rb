class CreateAuthorGenres < ActiveRecord::Migration
  def change
    create_table :author_genres do |t|
      t.integer :author_id
      t.integer :genre_id
    end
  end
end
