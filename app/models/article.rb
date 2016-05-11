class Article < ActiveRecord::Base
  
  # hash = {presence: true}
  # validates :title, hash

  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
end