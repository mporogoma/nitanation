class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    # @q = Product.ransack(params[:q])
    # @pagy, @products = pagy(Product.all.includes(:category).order(created_at: :desc))

    @q = Product.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
  
    # For low stock filter
    if params[:q] && params[:q][:low_stock_eq] == 'true'
      @q.build_condition if @q.conditions.empty?
      @q.conditions.first.predicate = 'lteq'
      @q.conditions.first.values = [Product.arel_table[:quantity], Product.arel_table[:low_stock_threshold]]
    end

    @pagy, @products = pagy(@q.result.includes(:category).distinct)
  end

  def show
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @categories = Category.all

    if @product.save
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :size, :quantity, :purchase_price, :selling_price, :category_id, :low_stock_threshold)
  end
end