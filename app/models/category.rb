class Category < ActiveRecord::Base
  validates_uniqueness_of :name
  validates :name, presence: true, length: {minimum: 3, maximum: 25}
end
