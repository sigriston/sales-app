class Vendor < ApplicationRecord
  include Retriable
  validates :name, presence: true
  validates :address, presence: true
end
