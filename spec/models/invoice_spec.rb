require 'rails_helper'

describe Invoice, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:status)}
  end

  describe 'associations' do
    it {should belong_to(:merchant)}
    it {should belong_to(:customer)}
  end
end