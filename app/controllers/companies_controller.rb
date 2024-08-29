class CompaniesController < ApplicationController
  def show
    @company = CNPJa::Client.call(params[:cnpj])

    render json: @company
  end
end
