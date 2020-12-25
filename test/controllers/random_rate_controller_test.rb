require 'test_helper'

class RandomRateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get random_rate_index_url
    assert_response :success
  end

end
