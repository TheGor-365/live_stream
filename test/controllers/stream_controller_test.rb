require "test_helper"

class StreamControllerTest < ActionDispatch::IntegrationTest
  test "should get live" do
    get stream_live_url
    assert_response :success
  end
end
