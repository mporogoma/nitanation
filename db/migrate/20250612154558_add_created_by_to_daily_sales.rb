class AddCreatedByToDailySales < ActiveRecord::Migration[8.0]
  def change
    add_reference :daily_sales, :created_by, foreign_key: { to_table: :users }
  end
end
