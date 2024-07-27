class TermsController < ApplicationController
  def show
    @term = Term.from_api(params[:term])
  end
end
