require "test_helper"

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
    assert_select "input[type=text][placeholder=?]", "Define a term…"
  end

  test "should redirect to term path on define" do
    post define_url, params: { term: "example" }
    assert_redirected_to term_path(term: "example")
  end
end
