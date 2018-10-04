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
    describe '#most_revenue' do
      it 'returns top x merchants ranked by total revenue' do



      end
    end
  end
end
