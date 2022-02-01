require "test_helper"

class Public::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_user_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_user_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_user_update_url
    assert_response :success
  end
end
