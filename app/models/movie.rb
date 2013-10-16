class Movie < ActiveRecord::Base
def self.all_ratings
        ['G','PG','PG-13','R']
    end

    scope :rating_in, ->(ratings) { where('rating IN (?)', ratings.keys) if ratings.respond_to? :keys }
    scope :order_by, ->(column) { order(column) if Movie.column_names.include? column }
end

