require 'test_helper'

class TermsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    term = 'example'
    api_response = {
      'word' => term,
      'definition' => 'This is a [sample] definition.',
      'example' => 'Here is a [sample] example.',
      'author' => 'API Author'
    }

    Term.stub :new, Term.new(api_response) do
      get term_url(term: term)
      assert_response :success
      assert_select 'h1', term
    end
  end
end
