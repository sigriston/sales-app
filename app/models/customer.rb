class Customer < ApplicationRecord
  include Retriable
  validates :name, presence: true
end
