class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :size
      t.integer :quantity
      t.decimal :purchase_price
      t.decimal :selling_price
      t.decimal :profit
      t.references :category, null: false, foreign_key: true
      t.integer :low_stock_threshold

      t.timestamps
    end
  end
end
