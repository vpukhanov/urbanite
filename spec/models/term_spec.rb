require 'rails_helper'

RSpec.describe Term, type: :model do
  let(:attributes) do
    {
      'word' => 'example',
      'definition' => 'This is a [sample] definition.',
      'example' => 'Here is a [sample] example.',
      'author' => 'Test Author'
    }
  end

  subject(:term) { described_class.new(attributes) }

  describe 'attributes' do
    it 'has a word' do
      expect(term.word).to eq('example')
    end

    it 'has a definition' do
      expect(term.definition).to include('This is a')
    end

    it 'has an example' do
      expect(term.example).to include('Here is a')
    end

    it 'has an author' do
      expect(term.author).to eq('Test Author')
    end
  end

  describe '#convert_links' do
    it 'converts bracketed words to links in the definition' do
      expect(term.definition).to include('<a href="/terms/sample">sample</a>')
    end

    it 'converts bracketed words to links in the example' do
      expect(term.example).to include('<a href="/terms/sample">sample</a>')
    end
  end

  describe '.from_api' do
    let(:api_response) do
      [{
        'word' => 'example',
        'definition' => 'This is a definition.',
        'example' => 'This is an example.',
        'author' => 'API Author'
      }]
    end

    before do
      allow(UrbanDictionaryService).to receive(:define).and_return(api_response)
    end

    it 'creates a Term object from API response' do
      term = described_class.from_api('example')
      expect(term).to be_a(Term)
      expect(term.word).to eq('example')
      expect(term.definition).to eq('This is a definition.')
      expect(term.example).to eq('This is an example.')
      expect(term.author).to eq('API Author')
    end

    context 'when API returns no results' do
      let(:api_response) { [] }

      it 'creates a Term object with "No definition found"' do
        term = described_class.from_api('nonexistent')
        expect(term).to be_a(Term)
        expect(term.word).to eq('nonexistent')
        expect(term.definition).to eq('No definition found.')
      end
    end
  end
end
