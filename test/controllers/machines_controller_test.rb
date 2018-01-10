require 'test_helper'

class MachinesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get machines_new_url
    assert_response :success
  end

  test "should get create" do
    get machines_create_url
    assert_response :success
  end

  test "should get edit" do
    get machines_edit_url
    assert_response :success
  end

  test "should get index" do
    get machines_index_url
    assert_response :success
  end

end
