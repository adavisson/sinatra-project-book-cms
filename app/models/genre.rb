class Genre < ActiveRecord::Base

  has_many :books
  has_many :author_genres
  has_many :authors, through: :author_genres

end