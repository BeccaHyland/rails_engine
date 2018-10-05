class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices

  default_scope { order(id: :asc) }

  def self.most_revenue(num_merchants)
    Merchant.unscoped.select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS total_revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order("total_revenue DESC")
    .limit(num_merchants)
  end


end
