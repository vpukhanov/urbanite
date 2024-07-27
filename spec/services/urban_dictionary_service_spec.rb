require 'rails_helper'

RSpec.describe UrbanDictionaryService do
  describe '.define' do
    let(:term) { 'example' }
    let(:api_response) do
      {
        'list' => [
          {
            'word' => term,
            'definition' => 'This is a definition.',
            'example' => 'This is an example.',
            'author' => 'API Author'
          }
        ]
      }
    end

    before do
      stub_request(:get, "https://api.urbandictionary.com/v0/define?term=#{term}")
        .to_return(status: 200, body: api_response.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns an array of definitions' do
      result = described_class.define(term)
      expect(result).to be_an(Array)
      expect(result.first).to include(
        'word' => term,
        'definition' => 'This is a definition.',
        'example' => 'This is an example.',
        'author' => 'API Author'
      )
    end

    context 'when API returns an error' do
      before do
        stub_request(:get, "https://api.urbandictionary.com/v0/define?term=#{term}")
          .to_return(status: 500, body: 'Internal Server Error')
      end

      it 'raises a NetworkError' do
        expect { described_class.define(term) }.to raise_error(UrbanDictionaryService::NetworkError, "API request failed with status 500")
      end
    end
  end
end
