class TermsController < ApplicationController
  def show
    @term = params[:term]
    @definition = "This is a placeholder definition for #{@term}"
  end
end
