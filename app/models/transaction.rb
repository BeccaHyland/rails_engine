class Transaction < ApplicationRecord
  belongs_to :invoice

  default_scope { order(id: :asc) }
end
