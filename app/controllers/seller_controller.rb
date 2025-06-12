class SellerController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_seller

  def dashboard
    @products = Product.all.includes(:category)
    @daily_sales = current_user.daily_sales.where(date: Date.current).includes(:product)
    @total_profit_today = @daily_sales.sum(:total_profit)
    @total_items_sold_today = @daily_sales.sum(:quantity_sold)
  end

  private

  def authorize_seller
    unless current_user.seller? || current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end