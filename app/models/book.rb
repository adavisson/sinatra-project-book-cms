class Book < ActiveRecord::Base

  belongs_to :author
  belongs_to :genre
  belongs_to :user

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end