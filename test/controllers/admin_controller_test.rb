require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
  	log_in_as(users(:one))
    get admin_url
    assert_response :success
  end

end
