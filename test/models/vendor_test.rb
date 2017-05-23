require 'test_helper'
require 'faker'

class VendorTest < ActiveSupport::TestCase
  test "add new vendor" do
    vendor = Vendor.new(name: "Luo Ji", address: "187J3X1")
    assert vendor.valid?
  end

  test "new vendor must have name" do
    vendor = Vendor.new(address: "187J3X1")
    refute vendor.valid?
    assert_not_nil vendor.errors[:name]
  end

  test "new vendor cannot have empty name" do
    vendor = Vendor.new(name: "", address: "187J3X1")
    refute vendor.valid?
    assert_not_nil vendor.errors[:name]
  end

  test "new vendor must have address" do
    vendor = Vendor.new(name: "Luo Ji")
    refute vendor.valid?
    assert_not_nil vendor.errors[:address]
  end

  test "new vendor cannot have empty address" do
    vendor = Vendor.new(name: "Luo Ji", address: "")
    refute vendor.valid?
    assert_not_nil vendor.errors[:address]
  end

  test "new vendor no name no address" do
    vendor = Vendor.new()
    refute vendor.valid?
    assert_not_nil vendor.errors[:name]
    assert_not_nil vendor.errors[:address]
  end

  test "new vendor empty name and address" do
    vendor = Vendor.new(name: "", address: "")
    refute vendor.valid?
    assert_not_nil vendor.errors[:name]
    assert_not_nil vendor.errors[:address]
  end

  test "cannot create vendor with same name & address" do
    vendor = Vendor.create(name: "Cheng Xin", address: "DX3906")
    assert vendor.persisted?
    assert_raise ActiveRecord::RecordNotUnique do
      Vendor.create(name: "Cheng Xin", address: "DX3906")
    end
  end

  test "find_or_create_by_retry successful" do
    vendor = Vendor.find_or_create_by_retry(name: "Yun Tianming",
                                            address: "Trisolaris")
    assert vendor.persisted?
    found = Vendor.find_or_create_by_retry(name: "Yun Tianming",
                                           address: "Trisolaris")
    assert_equal found, vendor
  end

  test "find_or_create_by race condition" do
    vendor_objs = Array.new(100) do
      { name: Faker::Name.name, address: Faker::Address.full_address }
    end
    num_threads = 4

    wait_for_it = true

    assert_raise ActiveRecord::RecordNotUnique do
      threads = num_threads.times.map do
        Thread.new do
          true while wait_for_it
          for vendor in vendor_objs do
            Vendor.find_or_create_by(name: vendor[:name],
                                     address: vendor[:address])
          end
        end
      end

      wait_for_it = false
      threads.each(&:join)
    end
  end

  test "find_or_create_by_retry NO race condition" do
    vendor_objs = Array.new(100) do
      { name: Faker::Name.name, address: Faker::Address.full_address }
    end
    num_threads = 4

    wait_for_it = true

    assert_nothing_raised do
      threads = num_threads.times.map do
        Thread.new do
          true while wait_for_it
          for vendor in vendor_objs do
            Vendor.find_or_create_by_retry(name: vendor[:name],
                                           address: vendor[:address])
          end
        end
      end

      wait_for_it = false
      threads.each(&:join)
    end
  end
end
