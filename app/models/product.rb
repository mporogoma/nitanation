class Product < ApplicationRecord
  belongs_to :category
  has_many :daily_sales, dependent: :destroy

  validates :name, :size, :quantity, :purchase_price, :selling_price, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :purchase_price, :selling_price, numericality: { greater_than: 0 }

  before_save :calculate_profit
  after_save :check_low_stock

  scope :low_stock, -> { where('quantity <= low_stock_threshold') }

  def calculate_profit
    self.profit = selling_price - purchase_price
  end

  def check_low_stock
    if quantity <= low_stock_threshold.to_i
      AdminMailer.low_stock_alert(self).deliver_later
    end
  end

  def update_quantity!(sold_quantity)
    update!(quantity: quantity - sold_quantity)
  end
end
