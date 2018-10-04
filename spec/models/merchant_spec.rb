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

      invoice1 = create(:invoice, merchant: @merchant1)
      invoice2 = create(:invoice, merchant: @merchant1)
      invoice3 = create(:invoice, merchant: @merchant1)
      create(:invoice_item, invoice: invoice1, unit_price: 10, quantity: 1 )
      create(:invoice_item, invoice: invoice2, unit_price: 20, quantity: 2 )
      create(:invoice_item, invoice: invoice3, unit_price: 30, quantity: 3 )
      create(:transaction, invoice: invoice1, result: "success")
      create(:transaction, invoice: invoice2, result: "success")
      create(:transaction, invoice: invoice3, result: "success")


      invoice4 = create(:invoice, merchant: @merchant2)
      invoice5 = create(:invoice, merchant: @merchant2)
      create(:invoice_item, invoice: invoice4, unit_price: 40, quantity: 4 )
      create(:invoice_item, invoice: invoice5, unit_price: 50, quantity: 5 )
      create(:transaction, invoice: invoice4, result: "success")
      create(:transaction, invoice: invoice5, result: "failed")

      invoice6 = create(:invoice, merchant: @merchant3)
      create(:invoice_item, invoice: invoice6, unit_price: 60, quantity: 6 )
      create(:invoice_item, invoice: invoice6, unit_price: 70, quantity: 7 )
      create(:transaction, invoice: invoice6, result: "success")
      create(:transaction, invoice: invoice6, result: "failed")
    end
    describe '#most_revenue(x)' do
      it 'returns top x merchants ranked by total revenue' do
        expect(Merchant.most_revenue(1)).to eq(@merchant3)
        expect(Merchant.most_revenue(2)).to eq([@merchant3, @merchant2])
      end
    end
  end
end
