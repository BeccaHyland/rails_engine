require 'rails_helper'

describe 'merchant search API' do~
  before (:each) do
    @merchant1 = Merchant.create(name: "AwesomeMerchant")
    @merchant2 = Merchant.create(name: "GreatMerchant")
    @merchant3 = Merchant.create(name: "GoodMerchant")
  end

  it 'returns one merchant by name' do
    search_params = "AwesomeMerchant"
    get "api/v1/merchants/find?name=#{search_params}"

    expect(response).to be_successful

    found_merchant = JSON.parse(response.body)

    expect(found_merchant.id).to eq(@merchant1.id)
  end

end
