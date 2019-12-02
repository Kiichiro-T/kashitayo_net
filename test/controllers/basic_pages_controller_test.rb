require 'test_helper'

class BasicPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get basic_pages_home_url
    assert_response :success
  end

end
