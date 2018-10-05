require 'rails_helper'

describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
  end

  describe 'associations' do
    it {should have_many(:invoices)}
    it {should have_many(:items)}
    it {should have_many(:invoice_items).through(:items)}
  end

  describe 'class methods' do
    before (:each) do

      @merchant1, @merchant2, @merchant3 = create_list(:merchant, 3)
      @invoice1 = create(:invoice, merchant: @merchant1)
      @invoice2 = create(:invoice, merchant: @merchant1)
      @invoice3 = create(:invoice, merchant: @merchant1)
          create(:invoice_item, invoice: @invoice1, unit_price: 10, quantity: 1 )
          create(:invoice_item, invoice: @invoice2, unit_price: 20, quantity: 2 )
          create(:invoice_item, invoice: @invoice3, unit_price: 30, quantity: 3 )
      create(:transaction, invoice: @invoice1, result: "success")
      create(:transaction, invoice: @invoice2, result: "success")
      create(:transaction, invoice: @invoice3, result: "success")

      @invoice4 = create(:invoice, merchant: @merchant2)
      @invoice5 = create(:invoice, merchant: @merchant2)
          create(:invoice_item, invoice: @invoice4, unit_price: 40, quantity: 4 )
          create(:invoice_item, invoice: @invoice5, unit_price: 50, quantity: 5 )
      create(:transaction, invoice: @invoice4, result: "success")
      create(:transaction, invoice: @invoice5, result: "failed")

      @invoice6 = create(:invoice, merchant: @merchant3)
          create(:invoice_item, invoice: @invoice6, unit_price: 60, quantity: 6 )
          create(:invoice_item, invoice: @invoice6, unit_price: 70, quantity: 7 )
      create(:transaction, invoice: @invoice6, result: "success")
      create(:transaction, invoice: @invoice6, result: "failed")
    end
    describe '#most_revenue(x)' do
      it 'returns top x merchants ranked by total revenue' do
        expect(Merchant.most_revenue(1)).to eq([@merchant3])
        expect(Merchant.most_revenue(2)).to eq([@merchant3, @merchant2])
      end
    end
  end
end

#regular RSPEC version of same before(:each) test setup as above
#save for reference

# customer = Customer.create(first_name: "Firstname", last_name: "Lastname")
# #Merchant 1
# @merchant1 = Merchant.create(name: "AwesomeMerchant")
# item1 = Item.create(name: "AwesomeItem", description: "It's awesome", unit_price: 10, merchant_id: @merchant1.id)
# invoice1 = Invoice.create(customer_id: customer.id, merchant_id: @merchant1.id, status: "shipped")
# invoice_item1 = InvoiceItem.create(item_id: item1.id, invoice_id: invoice1.id, quantity: 1, unit_price: 10)
# transaction1 = Transaction.create(invoice_id: invoice1.id, credit_card_number: '1234567890', result: 'success')
#
# #Merchant 2
# @merchant2 = Merchant.create(name: "GreatMerchant")
# item2 = Item.create(name: "GreatItem", description: "It's great", unit_price: 20, merchant_id: @merchant2.id)
# invoice2 = Invoice.create(customer_id: customer.id, merchant_id: @merchant2.id, status: "shipped")
# invoice_item2 = InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 2, unit_price: 20)
# transaction2 = Transaction.create(invoice_id: invoice2.id, credit_card_number: '1234567890', result: 'success')
#
# #Merchant 3
# @merchant3 = Merchant.create(name: "GoodMerchant")
# item3 = Item.create(name: "GoodItem", description: "It's good", unit_price: 30, merchant_id: @merchant3.id)
#
# invoice3 = Invoice.create(customer_id: customer.id, merchant_id: @merchant3.id, status: "shipped")
# invoice_item3 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice3.id, quantity: 3, unit_price: 30)
# transaction3 = Transaction.create(invoice_id: invoice3.id, credit_card_number: '1234567890', result: 'failed')
# transaction4 = Transaction.create(invoice_id: invoice3.id, credit_card_number: '1234567890', result: 'success')
#
# invoice4 = Invoice.create(customer_id: customer.id, merchant_id: @merchant3.id, status: "shipped")
# invoice_item4 = InvoiceItem.create(item_id: item3.id, invoice_id: invoice4.id, quantity: 4, unit_price: 40)
# transaction5 = Transaction.create(invoice_id: invoice4.id, credit_card_number: '1234567890', result: 'failed')
