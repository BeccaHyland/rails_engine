require 'rails_helper'

describe 'most_revenue API' do
  before (:each) do
    customer = Customer.create(first_name: "Firstname", last_name: "Lastname")
    #Merchant 1
    @merchant1 = Merchant.create(name: "AwesomeMerchant")
    item1 = Item.create(name: "AwesomeItem", description: "It's awesome", unit_price: 10, merchant_id: @merchant1.id)
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: @merchant1.id, status: "shipped")
    invoice_item1 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 1, unit_price: 10)
    transaction1 = Transaction.create(invoice_id: invoice1.id, credit_card_number: '1234567890', result: 'success')

    #Merchant 2
    @merchant2 = Merchant.create(name: "GreatMerchant")
    item2 = Item.create(name: "GreatItem", description: "It's great", unit_price: 20, merchant_id: @merchant2.id)
    invoice2 = Invoice.create(customer_id: customer.id, merchant_id: @merchant2.id, status: "shipped")
    invoice_item2 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 20)
    transaction2 = Transaction.create(invoice_id: invoice2.id, credit_card_number: '1234567890', result: 'success')

    #Merchant 3
    @merchant3 = Merchant.create(name: "GoodMerchant")
    item3 = Item.create(name: "GoodItem", description: "It's good", unit_price: 30, merchant_id: @merchant3.id)

    invoice3 = Invoice.create(customer_id: customer.id, merchant_id: @merchant3.id, status: "shipped")
    invoice_item3 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice3.id, quantity: 3, unit_price: 30)
    transaction3 = Transaction.create(invoice_id: invoice3.id, credit_card_number: '1234567890', result: 'failed')
    transaction4 = Transaction.create(invoice_id: invoice3.id, credit_card_number: '1234567890', result: 'success')

    invoice4 = Invoice.create(customer_id: customer.id, merchant_id: @merchant3.id, status: "shipped")
    invoice_item4 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice4.id, quantity: 4, unit_price: 40)
    transaction5 = Transaction.create(invoice_id: invoice4.id, credit_card_number: '1234567890', result: 'failed')
  end

  it 'returns the top x merchants ranked by total revenue' do
    x = 2
    get "/api/v1/merchants/most_revenue?quantity=#{x}"

    expect(response).to be_successful

    most_revenue_merchants = JSON.parse(response.body)

    expect(most_revenue_merchants.count).to eq(x)
    expect(most_revenue_merchants[0]["id"]).to eq(@merchant3.id)
    expect(most_revenue_merchants[1]["id"]).to eq(@merchant2.id)

  end
end
