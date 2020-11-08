class Discount < ApplicationRecord
  validates_presence_of :discount_percent, :min_quantity

  belongs_to :merchant
end
