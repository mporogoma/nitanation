class DailySale < ApplicationRecord
  belongs_to :product
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'

  validates :date, :quantity_sold, :remaining_quantity, :total_profit, presence: true
  validates :quantity_sold, :remaining_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :total_profit, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_date, :calculate_totals
  after_create :update_product_quantity

  def self.ransackable_attributes(auth_object = nil)
    %w[quantity_sold remaining_quantity total_profit date created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[product created_by]
  end

  # For searching product name through the association
  ransacker :product_name, formatter: proc { |v| v.downcase } do |parent|
    Arel::Nodes::NamedFunction.new('LOWER', [Product.arel_table[:name]])
  end

  private

  def set_date
    self.date ||= Date.current
  end

  def calculate_totals
    if product
      self.remaining_quantity = product.quantity - quantity_sold
      self.total_profit = quantity_sold * product.profit
    end
  end

  def update_product_quantity
    product.update_quantity!(quantity_sold)
  end
end
