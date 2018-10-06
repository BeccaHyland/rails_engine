require 'rails_helper'

describe 'merchant search API' do
  it 'returns one merchant by name' do
    merchant1 = create(:merchant, name: "AwesomeMerchant")
    merchant2 = create(:merchant, name: "GreatMerchant")
    merchant3 = create(:merchant, name: "GoodMerchant")

    search_params = "AwesomeMerchant"
    get "/api/v1/merchants/find?name=#{search_params}"

    expect(response).to be_successful

    found_merchant = JSON.parse(response.body)

    expect(found_merchant["id"]).to eq(merchant1.id)
  end

  it 'returns all merchants by date' do
    merchant1, merchant2 = create_list(:merchant, 2, created_at: '2018-09-09 00:00:00')
    merchant3 = create(:merchant, created_at: '2018-10-10 00:00:00')

    get "/api/v1/merchants/find_all?created_at=#{merchant1.created_at}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(response.body).to include("#{merchant1.id}")
    expect(response.body).to include("#{merchant2.id}")
    expect(response.body).to_not include("#{merchant3.id}")
  end
end

describe 'random merchant API' do
  it 'returns one random merchant' do
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)

    get "/api/v1/merchants/random"

    random_row = JSON.parse(response.body)

    expect(response).to be_successful
    expect(random_row.keys).to contain_exactly("id", "name")
    expect(random_row["id"]).to eq(merchant1.id).or eq(merchant2.id).or eq(merchant3.id)
  end
end
