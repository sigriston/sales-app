require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @vendor = vendors(:one)
    @alt_vendor = vendors(:two)
  end

  test "add new product" do
    product = Product.new(description: "French Fries",
                          price: 5.5,
                          vendor: @vendor)
    assert product.valid?
  end

  test "new product must have description" do
    product = Product.new(price: 5.5,
                          vendor: @vendor)
    refute product.valid?
    assert_not_nil product.errors[:description]
  end

  test "new product cannot have empty description" do
    product = Product.new(description: "",
                          price: 5.5,
                          vendor: @vendor)
    refute product.valid?
    assert_not_nil product.errors[:description]
  end

  test "new product must have price" do
    product = Product.new(description: "French Fries",
                          vendor: @vendor)
    refute product.valid?
    assert_not_nil product.errors[:price]
  end

  test "new product must have vendor" do
    product = Product.new(description: "French Fries",
                          price: 5.5)
    refute product.valid?
    assert_not_nil product.errors[:vendor]
  end

  test "cannot create product with same desc & vendor" do
    product = Product.create(description: "Double Cheeseburger",
                             price: 8.0,
                             vendor: @vendor)
    assert product.persisted?
    assert_raise ActiveRecord::RecordNotUnique do
      Product.create(description: "Double Cheeseburger",
                     price: 10.0,
                     vendor: @vendor)
    end
  end

  test "can create product with same desc & different vendor" do
    product = Product.create(description: "Double Cheeseburger",
                             price: 8.0,
                             vendor: @vendor)
    assert product.persisted?
    assert_nothing_raised do
      alt_product = Product.create(description: "Double Cheeseburger",
                                   price: 10.0,
                                   vendor: @alt_vendor)
      assert alt_product.persisted?
    end
  end

  test "find_or_create_by_retry successful" do
    product = Product.find_or_create_by_retry(description: "Diet Soda",
                                              price: 2.5,
                                              vendor: @vendor)
    assert product.persisted?
    found = Product.find_or_create_by_retry(description: "Diet Soda",
                                            vendor: @vendor)
    assert_equal found, product
  end

  test "find_or_create_by race condition" do
    product_objs = Array.new(100) do
      { description: Faker::Name.unique.name,
        price: Faker::Number.decimal(1, 2) }
    end
    num_threads = 4

    wait_for_it = true

    assert_raise ActiveRecord::RecordNotUnique do
      threads = num_threads.times.map do
        Thread.new do
          true while wait_for_it
          for product in product_objs do
            Product.find_or_create_by(description: product[:description],
                                      price: product[:price],
                                      vendor: @vendor)
          end
        end
      end

      wait_for_it = false
      threads.each(&:join)
    end
  end

  test "find_or_create_by_retry NO race condition" do
    product_objs = Array.new(100) do
      { description: Faker::Name.unique.name,
        price: Faker::Number.decimal(1, 2) }
    end
    num_threads = 4

    wait_for_it = true

    assert_nothing_raised do
      threads = num_threads.times.map do
        Thread.new do
          true while wait_for_it
          for product in product_objs do
            Product.find_or_create_by_retry(description: product[:description],
                                            price: product[:price],
                                            vendor: @vendor)
          end
        end
      end

      wait_for_it = false
      threads.each(&:join)
    end
  end
end
