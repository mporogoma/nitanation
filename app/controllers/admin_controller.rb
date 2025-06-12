class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def dashboard
    @products = Product.all.includes(:category)
    @low_stock_products = Product.low_stock
    @categories = Category.all
    @users = User.all
    @daily_sales = DailySale.where(date: Date.current).includes(:product)
    @total_profit_today = @daily_sales.sum(:total_profit)
    @total_items_sold_today = @daily_sales.sum(:quantity_sold)
  end

  def users
    @pagy, @users = pagy(User.all.order(created_at: :desc))
  end

  def update_user_role
    user = User.find(params[:user_id])
    if params[:role] == 'admin'
      user.add_role(:admin)
    else
      user.remove_role(:admin)
      user.add_role(:seller)
    end
    redirect_to admin_users_path, notice: "User role updated successfully."
  end

  private

  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end