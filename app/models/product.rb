class Product < ApplicationRecord
  include Retriable
  belongs_to :vendor
  validates :description, presence: true
  validates :price, presence: true
end
