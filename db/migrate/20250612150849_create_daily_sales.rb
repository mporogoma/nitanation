class CreateDailySales < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_sales do |t|
      t.date :date
      t.references :product, null: false, foreign_key: true
      t.integer :quantity_sold
      t.integer :remaining_quantity
      t.decimal :total_profit

      t.timestamps
    end
  end
end
