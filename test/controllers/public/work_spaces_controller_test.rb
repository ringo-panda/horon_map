require "test_helper"

class Public::WorkSpacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_canvases_index_url
    assert_response :success
  end
end
