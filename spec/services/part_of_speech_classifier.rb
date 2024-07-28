require "rails_helper"

RSpec.describe PartOfSpeechClassifier do
  let(:classifier) { described_class.new }

  describe "#classify" do
    it "classifies a noun correctly" do
      expect(described_class.classify("cat", "A small domesticated carnivorous mammal.")).to eq("noun")
    end

    it "classifies a verb correctly" do
      expect(described_class.classify("run", "To move at a speed faster than a walk.")).to eq("verb")
    end

    it "classifies an adjective correctly" do
      expect(described_class.classify("beautiful", "Pleasing the senses or mind aesthetically.")).to eq("adjective")
    end

    it "classifies an adverb correctly" do
      expect(described_class.classify("quickly", "At a fast speed; rapidly.")).to eq("adverb")
    end

    it "returns nil for multi-word phrases" do
      expect(classifier.classify("ice cream", "A sweet frozen food.")).to be_nil
    end

    it "uses the definition for context when the word alone is ambiguous" do
      expect(classifier.classify("bank", "A financial institution.")).to eq("noun")
      expect(classifier.classify("bank", "To rely on or trust in.")).to eq("verb")
    end

    it "handles capitalized words" do
      expect(classifier.classify("Apple", "A technology company.")).to eq("noun")
    end

    it "classifies less common parts of speech" do
      expect(classifier.classify("in", "Used to indicate location.")).to eq("preposition")
      expect(classifier.classify("and", "Used to connect words.")).to eq("conjugation")
      expect(classifier.classify("the", "Definite article.")).to eq("determiner")
    end

    it 'returns "misc" for unknown or unclassifiable words' do
      expect(classifier.classify("xylophone", "A musical instrument.")).to eq("misc")
    end

    it "handles words with special characters" do
      expect(classifier.classify("co-operate", "To work together.")).to eq("verb")
    end
  end

  describe "edge cases" do
    it "handles empty strings" do
      expect(classifier.classify("", "")).to be_nil
    end

    it "handles nil input gracefully" do
      expect { classifier.classify(nil, nil) }.not_to raise_error
    end

    it "handles very long words" do
      expect(classifier.classify("supercalifragilisticexpialidocious", "An extraordinarily good word.")).to eq("adjective")
    end

    it "handles words with numbers" do
      expect(classifier.classify("4g", "Fourth generation of mobile networks.")).to eq("noun")
    end
  end
end
