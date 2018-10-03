require 'rails_helper'

describe Transaction, type: :model do
  describe 'associations' do
    it {should belong_to(:invoice)}
  end
end
