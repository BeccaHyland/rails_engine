class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices

  default_scope { order(id: :asc) }
end
