class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer :discount_percent
      t.integer :min_quantity
      t.references :merchant, foreign_key: true 

      t.timestamps
    end
  end
end
