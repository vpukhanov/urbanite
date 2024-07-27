class TermsController < ApplicationController
  def show
    @term = Term.from_api(params[:term])
  rescue StandardError => e
    Rails.logger.error("Error fetching definition: #{e.message}")
    @term = Term.new(word: params[:word], definition: "An error occured while fetching the definition.")
  end
end
