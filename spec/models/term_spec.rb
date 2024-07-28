require "rails_helper"

RSpec.describe Term, type: :model do
  let(:attributes) do
    {
      "word" => "example",
      "definition" => "This is a [sample] definition.",
      "example" => "Here is a [sample] example.",
      "author" => "Test Author",
      "part_of_speech" => "noun"
    }
  end

  subject(:term) { described_class.new(attributes) }

  describe "attributes" do
    it "has a word" do
      expect(term.word).to eq("example")
    end

    it "has a definition" do
      expect(term.definition).to include("This is a")
    end

    it "has an example" do
      expect(term.example).to include("Here is a")
    end

    it "has an author" do
      expect(term.author).to eq("Test Author")
    end

    it "has a part of speech" do
      expect(term.part_of_speech).to eq("noun")
    end
  end

  describe "#convert_links" do
    it "converts bracketed words to links in the definition" do
      expect(term.definition).to include('<a href="/terms/sample">sample</a>')
    end

    it "converts bracketed words to links in the example" do
      expect(term.example).to include('<a href="/terms/sample">sample</a>')
    end
  end
end
