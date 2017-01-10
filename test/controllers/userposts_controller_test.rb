require 'test_helper'

class UserpostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get userposts_index_url
    assert_response :success
  end

end
