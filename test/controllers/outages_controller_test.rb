require 'test_helper'

class OutagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get outages_new_url
    assert_response :success
  end

  test "should get edit" do
    get outages_edit_url
    assert_response :success
  end

  test "should get show" do
    get outages_show_url
    assert_response :success
  end

  test "should get index" do
    get outages_index_url
    assert_response :success
  end

end
