class LowStockCheckJob < ApplicationJob
  queue_as :default

  def perform
    Product.low_stock.each do |product|
      AdminMailer.low_stock_alert(product).deliver_later
    end
  end
end