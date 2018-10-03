class Item < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :name, :description, :unit_price

  default_scope { order(id: :asc) }
end
