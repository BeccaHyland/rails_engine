class Api::V1::Merchants::RandomController < ApplicationController
  def show
    render json: Merchant.random_row
  end
end
