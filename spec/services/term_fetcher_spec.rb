require 'rails_helper'

RSpec.describe TermFetcher do
  describe '.fetch' do
    let(:word) { 'example' }
    let(:api_response) do
      [ {
        'word' => word,
        'definition' => 'This is a [sample] definition.',
        'example' => 'Here is a [sample] example.',
        'author' => 'API Author'
      } ]
    end

    before do
      allow(UrbanDictionaryService).to receive(:define).with(word).and_return(api_response)
    end

    it 'returns a Term object' do
      result = described_class.fetch(word)
      expect(result).to be_a(Term)
    end

    it 'sets the correct attributes on the Term object' do
      result = described_class.fetch(word)
      expect(result.word).to eq(word)
      expect(result.definition).to eq('This is a <a href="/terms/sample">sample</a> definition.')
      expect(result.example).to eq('Here is a <a href="/terms/sample">sample</a> example.')
      expect(result.author).to eq('API Author')
    end
  end
end
