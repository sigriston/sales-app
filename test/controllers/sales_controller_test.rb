require 'test_helper'

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sales_path
    assert_response :success
  end

  test "should get upload" do
    get upload_sales_path
    assert_response :success
  end

  test "should post import" do
    post import_sales_path
    assert_response :success
  end

end
