class AddUserToDailySales < ActiveRecord::Migration[8.0]
  def change
    add_reference :daily_sales, :user, null: false, foreign_key: true
  end
end
