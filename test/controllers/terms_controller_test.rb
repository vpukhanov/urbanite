require "test_helper"

class TermsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get term_url(term: "example")
    assert_response :success
    assert_select "h1", "example"
  end
end
