# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :users, -> { where role: :merchant }
  has_many :orders, through: :items
  has_many :discounts

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  validates_inclusion_of :enabled?, in: [true, false]

  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def pending_orders
    orders.where(status: 'Pending').distinct
  end

  def disable_merchant
    update(enabled?: false)
    items.update(active?: false)
  end

  def enable_merchant
    update(enabled?: true)
    items.update(active?: true)
  end
end
