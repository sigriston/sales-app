class Sale < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  validates :quantity, presence: true

  def total
    product.price * quantity
  end

  def self.grandtotal
    joins(:product).sum("price * quantity")
  end

  def self.create_row(row)
    customer = Customer.find_or_create_by_retry(name: row[:customer])

    vendor = Vendor.find_or_create_by_retry(name: row[:vendor],
                                            address: row[:address]) do |v|
      v.address = row[:address]
    end

    product = Product.find_or_create_by_retry(description: row[:description],
                                              vendor: vendor) do |p|
      p.price = row[:price]
    end

    create(customer: customer, product: product, quantity: row[:quantity])
  end

  def self.bulk_create_row(rows)
    ActiveRecord::Base.transaction do
      rows.map do |row|
        create_row(row)
      end
    end
  end
end
