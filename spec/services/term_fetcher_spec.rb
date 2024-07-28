require "rails_helper"

RSpec.describe TermFetcher do
  describe ".fetch" do
    let(:word) { "example" }
    let(:api_response) do
      [ {
        "word" => word,
        "definition" => "This is a [sample] definition.",
        "example" => "Here is a [sample] example.",
        "author" => "API Author"
      } ]
    end
    let(:part_of_speech) { "noun" }

    before do
      allow(UrbanDictionaryService).to receive(:define).with(word).and_return(api_response)
      allow(PartOfSpeechClassifier).to receive(:classify).with(word, "This is a [sample] definition.").and_return(part_of_speech)
    end

    it "returns a Term object" do
      result = described_class.fetch(word)
      expect(result).to be_a(Term)
    end

    it "sets the correct attributes on the Term object" do
      result = described_class.fetch(word)
      expect(result.word).to eq(word)
      expect(result.definition).to eq('This is a <a href="/terms/sample">sample</a> definition.')
      expect(result.example).to eq('Here is a <a href="/terms/sample">sample</a> example.')
      expect(result.author).to eq("API Author")
      expect(result.part_of_speech).to eq(part_of_speech)
    end

    it "calls UrbanDictionaryService.define with the correct word" do
      described_class.fetch(word)
      expect(UrbanDictionaryService).to have_received(:define).with(word)
    end

    it "calls PartOfSpeechClassifier.classify with the correct word and definition" do
      described_class.fetch(word)
      expect(PartOfSpeechClassifier).to have_received(:classify).with(word, "This is a [sample] definition.")
    end

    context "when PartOfSpeechClassifier returns nil" do
      let(:part_of_speech) { nil }

      it "sets part_of_speech to nil on the Term object" do
        result = described_class.fetch(word)
        expect(result.part_of_speech).to be_nil
      end
    end
  end
end
