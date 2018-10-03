class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices

  default_scope { order(id: :asc) }
end
