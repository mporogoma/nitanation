class DailySalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_sale, only: [:show, :edit, :update, :destroy]
  before_action :set_products, only: [:new, :edit, :create, :update]

  def index
    if current_user.admin?
      @pagy, @daily_sales = pagy(DailySale.all.includes(:product, :created_by).order(date: :desc))
    else
      @pagy, @daily_sales = pagy(current_user.daily_sales.includes(:product).order(date: :desc))
    end
  end

  def show
  end

  def new
    @daily_sale = DailySale.new(date: Date.current)
  end

  def edit
  end

  def create
   # @daily_sale = DailySale.new(daily_sale_params)
    @daily_sale = DailySale.new(daily_sale_params.merge(created_by: current_user))
    @daily_sale.created_by = current_user

    if @daily_sale.save
      redirect_to daily_sales_path, notice: 'Daily sale was successfully created.'
    else
      render :new
    end
  end

  def update
    if @daily_sale.update(daily_sale_params)
      redirect_to daily_sales_path, notice: 'Daily sale was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @daily_sale.destroy
    respond_to do |format|
      format.html { redirect_to daily_sales_url, notice: 'Daily sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_daily_sale
    @daily_sale = DailySale.find(params[:id])
  end

  def set_products
    @products = Product.all
  end

  def daily_sale_params
    params.require(:daily_sale).permit(:product_id, :quantity_sold, :date)
  end
end