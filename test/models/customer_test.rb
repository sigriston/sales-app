require 'test_helper'

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
    assert customer.valid?
    assert_raises(ActiveRecord::RecordNotUnique) do
      Customer.create(name: "Thufir Hawat")
    end
  end
end
