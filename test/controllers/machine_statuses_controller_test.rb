require 'test_helper'

class MachineStatusesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get machine_statuses_edit_url
    assert_response :success
  end

  test "should get create" do
    get machine_statuses_create_url
    assert_response :success
  end

end
