require 'rails_helper'

describe 'merchant items API' do
  it 'returns all items for one merchant' do
    merchant1, merchant2 = create_list(:merchant, 2)
    item1, item2 = create_list(:item, 2, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items[0]["id"]).to eq(item1.id)
    expect(items[1]["id"]).to eq(item2.id)
  end
end
