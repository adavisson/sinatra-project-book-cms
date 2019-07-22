module Slugifiable

  module ClassMethods
    def find_by_slug(string)
      self.all.each do |item|
        if item.slug == string
          return item
        end
      end
    end

    def find_book_by_slug(string)
      self.all.each do |item|
        if item.slug_book == string
          return item
        end
      end
    end
    
  end

  module InstanceMethods
    def slug
      self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def slug_book
      self.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end

end