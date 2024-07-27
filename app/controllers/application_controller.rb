class ApplicationController < ActionController::Base
  protected

  def not_found!
    response.headers["Turbo-Visit"] = "false"
    render :not_found, status: :not_found
  end
end
