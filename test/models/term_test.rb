require 'test_helper'

class TermTest < ActiveSupport::TestCase
  def setup
    @attributes = {
      'word' => 'example',
      'definition' => 'This is a [sample] definition.',
      'example' => 'Here is a [sample] example.',
      'author' => 'Test Author'
    }
    @term = Term.new(@attributes)
  end

  test "should have attributes" do
    assert_equal 'example', @term.word
    assert_includes @term.definition, 'This is a'
    assert_includes @term.example, 'Here is a'
    assert_equal 'Test Author', @term.author
  end

  test "should convert links in definition" do
    assert_includes @term.definition, '<a href="/terms/sample">sample</a>'
  end

  test "should convert links in example" do
    assert_includes @term.example, '<a href="/terms/sample">sample</a>'
  end
end
