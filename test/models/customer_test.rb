require 'test_helper'
require 'faker'

class CustomerTest < ActiveSupport::TestCase
  test "add new customer" do
    customer = Customer.new(name: "Paul Atreides")
    assert customer.valid?
  end

  test "new customer must have name" do
    customer = Customer.new()
    refute customer.valid?
    assert_not_nil customer.errors[:name]
  end

  test "new customer cannot have empty name" do
    customer = Customer.new(name: "")
    refute customer.valid?
    assert_not_nil customer.errors[:name]
  end

  test "cannot create customer with same name" do
    customer = Customer.create(name: "Thufir Hawat")
    assert customer.persisted?
    assert_raise ActiveRecord::RecordNotUnique do
      Customer.create(name: "Thufir Hawat")
    end
  end

  test "find_or_create_by_retry successful" do
    customer = Customer.find_or_create_by_retry(name: "Lady Jessica")
    assert customer.persisted?
    found = Customer.find_or_create_by_retry(name: "Lady Jessica")
    assert_equal found, customer
  end

  test "find_or_create_by race condition" do
    customer_names = Array.new(100) { Faker::Name.name }
    num_threads = 4

    wait_for_it = true

    assert_raise ActiveRecord::RecordNotUnique do
      threads = num_threads.times.map do
        Thread.new do
          true while wait_for_it
          for customer_name in customer_names do
            Customer.find_or_create_by(name: customer_name)
          end
        end
      end

      wait_for_it = false
      threads.each(&:join)
    end
  end

  test "find_or_create_by_retry NO race condition" do
    customer_names = Array.new(100) { Faker::Name.name }
    num_threads = 4

    wait_for_it = true

    assert_nothing_raised do
      threads = num_threads.times.map do
        Thread.new do
          true while wait_for_it
          for customer_name in customer_names do
            Customer.find_or_create_by_retry(name: customer_name)
          end
        end
      end

      wait_for_it = false
      threads.each(&:join)
    end
  end
end
