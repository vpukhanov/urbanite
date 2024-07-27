class TermsController < ApplicationController
  def show
    @term = fetch_term_from_api(params[:term])
  end

  private

  def fetch_term_from_api(word)
    api_response = {
      'word' => word,
      'definition' => "This is a [sample] definition for #{word}.",
      'example' => "Here's a [sample] example using #{word}.",
      'author' => 'API Author'
    }

    Term.new(api_response)
  end
end
