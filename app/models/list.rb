class List < ApplicationRecord
  validates_presence_of :name
  
  has_many :items
end
