require 'rails_helper'

RSpec.describe "Terms", type: :request do
  describe "GET /terms/:term" do
    let(:term) { 'example' }
    let(:api_response) do
      [{
        'word' => term,
        'definition' => 'This is a [sample] definition.',
        'example' => 'Here is a [sample] example.',
        'author' => 'API Author'
      }]
    end

    before do
      allow(UrbanDictionaryService).to receive(:define).with(term).and_return(api_response)
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

    context "when API returns a NotFoundError" do
      before do
        allow(UrbanDictionaryService).to receive(:define).with(term).and_raise(UrbanDictionaryService::NotFoundError)
      end

      it "renders the 404 error page" do
        get term_path(term: term)
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Term Not Found")
        expect(response.headers["Turbo-Visit"]).to eq("false")
      end
    end

    context "when API returns a server error" do
      before do
        allow(UrbanDictionaryService).to receive(:define).with(term).and_raise(UrbanDictionaryService::NetworkError)
      end

      it "renders the 500 error page" do
        get term_path(term: term)
        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include("We're sorry, but something went wrong")
      end
    end
  end
end
