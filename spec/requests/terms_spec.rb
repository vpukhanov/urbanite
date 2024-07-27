require 'rails_helper'

RSpec.describe "Terms", type: :request do
  describe "GET /terms/:term" do
    let(:term) { 'example' }
    let(:api_response) do
      {
        'word' => term,
        'definition' => 'This is a [sample] definition.',
        'example' => 'Here is a [sample] example.',
        'author' => 'API Author'
      }
    end

    before do
      allow(Term).to receive(:from_api).with(term).and_return(Term.new(api_response))
    end

    it "returns a successful response" do
      get term_path(term: term)
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get term_path(term: term)
      expect(response).to render_template(:show)
    end

    it "displays the term" do
      get term_path(term: term)
      expect(response.body).to include(term)
    end
  end
end
