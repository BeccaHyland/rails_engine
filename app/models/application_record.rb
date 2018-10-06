class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random_row
    unscoped.order(Arel.sql("RANDOM()")).first
  end
end
