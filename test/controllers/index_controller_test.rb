require "test_helper"

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
    assert_select "input[type=text][placeholder=?]", "Define a term…"
  end
end
