require "test_helper"

class Admin::WorkSpacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_canvases_index_url
    assert_response :success
  end
end
