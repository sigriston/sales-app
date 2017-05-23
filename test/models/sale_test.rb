require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  setup do
    @product = products(:one)
    @alt_product = products(:two)
    @customer = customers(:one)
    @alt_customer = customers(:two)
    @rows = [
      {
        customer: "Chance Predovic III",
        description: "ASUS ROG GeForce GTX 1080 STRIX-GTX1080-A8G-GAMING 8GB",
        price: 569.99,
        quantity: 1,
        address: "Apt. 277 717 Anastasia Tunnel, Adellaville, NH 20403",
        vendor: "Huel LLC"
      },
      {
        customer: "Miss Felicia Dickens",
        description: "EVGA GeForce GTX 1080 Ti FE 11G-P4-6390-KR 11GB",
        price: 699.99,
        quantity: 2,
        address: "58127 Boyer Mountains, Creminberg, IL 76309-7412",
        vendor: "Hane-Wiegand"
      }
    ]
    @diff_address_row = {
      customer: "Miss Felicia Dickens",
      description: "EVGA GeForce GTX 1080 Ti FE 11G-P4-6390-KR 11GB",
      price: 699.99,
      quantity: 2,
      address: "17888 Willms Vista, West Donavonberg, FL 89286",
      vendor: "Hane-Wiegand"
    }
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

  test "total price for one sale" do
    sale = sales(:one)
    assert_equal 23.97, sale.total
  end

  test "grandtotal for all sales" do
    assert_equal 78.72, Sale.grandtotal
  end

  test "create_row" do
    sale = Sale.create_row(@rows[0])
    assert sale.persisted?
    assert sale.customer.persisted?
    assert sale.product.persisted?
    assert sale.product.vendor.persisted?

    assert_equal @rows[0][:customer], sale.customer.name
    assert_equal @rows[0][:description], sale.product.description
    assert_equal @rows[0][:price], sale.product.price
    assert_equal @rows[0][:quantity], sale.quantity
    assert_equal @rows[0][:address], sale.product.vendor.address
    assert_equal @rows[0][:vendor], sale.product.vendor.name
  end

  test "bulk_create_row" do
    sale_list = Sale.bulk_create_row(@rows)

    assert_not_empty sale_list

    for sale, row in sale_list.zip(@rows)
      assert sale.persisted?
      assert sale.customer.persisted?
      assert sale.product.persisted?
      assert sale.product.vendor.persisted?

      assert_equal row[:customer], sale.customer.name
      assert_equal row[:description], sale.product.description
      assert_equal row[:price], sale.product.price
      assert_equal row[:quantity], sale.quantity
      assert_equal row[:address], sale.product.vendor.address
      assert_equal row[:vendor], sale.product.vendor.name
    end
  end

  test "create_row allow vendor with different address" do
    sale = Sale.create_row(@rows[1])
    alt_sale = Sale.create_row(@diff_address_row)
    assert_not_equal alt_sale.product.vendor.address,
      sale.product.vendor.address
  end
end
