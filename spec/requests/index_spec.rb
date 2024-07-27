require 'rails_helper'

RSpec.describe "Index", type: :request do
  describe "GET /" do
    it "returns a successful response" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get root_path
      expect(response).to render_template(:index)
    end

    it "has the correct input field" do
      get root_path
      expect(response.body).to include('placeholder="Define a term…"')
    end
  end

  describe "POST /define" do
    it "redirects to the term path" do
      post define_path, params: { term: "example" }
      expect(response).to redirect_to(term_path(term: "example"))
    end
  end
end
