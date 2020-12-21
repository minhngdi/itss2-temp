require 'test_helper'

class ComparesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get compares_index_url
    assert_response :success
  end

end
