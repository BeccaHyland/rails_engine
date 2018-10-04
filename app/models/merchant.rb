class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :items

  default_scope { order(id: :asc) }
end
