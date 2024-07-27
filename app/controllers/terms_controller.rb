class TermsController < ApplicationController
  def show
    @term = TermFetcher.fetch(params[:term])
  rescue UrbanDictionaryService::NotFoundError
    render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
  rescue UrbanDictionaryService::NetworkError => e
    Rails.logger.error("Urban Dictionary API error: #{e.message}")
    render file: Rails.public_path.join("500.html"), status: :internal_server_error, layout: false
  end
end
