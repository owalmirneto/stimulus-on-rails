class CompaniesController < ApplicationController
  layout false

  def show
    @company = CNPJa::Client.call(params[:cnpj])

    respond_to do |format|
      format.html
      format.json { render json: @company }
    end
  end
end
