class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  validates_presence_of :status

  default_scope { order(id: :asc) }
end
