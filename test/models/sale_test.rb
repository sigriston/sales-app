require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
    @alt_product = products(:two)
    @customer = customers(:one)
    @alt_customer = customers(:two)
  end

  test "add new sale" do
    sale = Sale.new(customer: @customer,
                    product: @product,
                    quantity: 4)
    assert sale.valid?
  end

  test "new sale must have customer" do
    sale = Sale.new(product: @product,
                    quantity: 4)
    refute sale.valid?
    assert_not_nil sale.errors[:customer]
  end

  test "new sale must have product" do
    sale = Sale.new(customer: @customer,
                    quantity: 4)
    refute sale.valid?
    assert_not_nil sale.errors[:product]
  end

  test "new sale must have quantity" do
    sale = Sale.new(customer: @customer,
                    product: @product)
    refute sale.valid?
    assert_not_nil sale.errors[:quantity]
  end

  test "can create 2 identical sales" do
    sale = Sale.create(customer: @customer,
                       product: @product,
                       quantity: 4)
    assert sale.persisted?
    assert_nothing_raised do
      alt_sale = Sale.create(customer: @customer,
                             product: @product,
                             quantity: 4)
      assert alt_sale.persisted?
    end
  end
end
