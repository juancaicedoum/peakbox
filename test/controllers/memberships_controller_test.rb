require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get status" do
    get memberships_status_url
    assert_response :success
  end
end
