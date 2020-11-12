class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def subtract_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] -= 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    item.price * @contents[item.id.to_s]
  end

  def total
    @contents.sum do |item_id,quantity|
      if quantity_met?(item_id, quantity)
        discounted_total(item_id, quantity)
      else
        Item.find(item_id).price * quantity
      end
    end
  end

  def discounted_total(item_id, quantity)
    item = Item.find(item_id)
    applicable_discounts = item.merchant.discounts.where('min_quantity <= ?', quantity)
    greatest_discount = applicable_discounts.order('discount_percent desc').first
    (item.price * quantity) - ((item.price * quantity) * (greatest_discount.discount_percent * 0.01))
  end

  def quantity_met?(item_id, quantity)
    item = Item.find(item_id)
    item.merchant.discounts.where('min_quantity <= ?', quantity).any?
  end
end
