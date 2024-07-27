class IndexController < ApplicationController
  def index
  end
  
  def define
    redirect_to term_path(term: params[:term])
  end
end
