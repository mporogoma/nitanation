# app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    if user_signed_in?
      redirect_to current_user.admin? ? admin_dashboard_path : seller_dashboard_path
    else
      # Initialize resource variables for the view
      @resource = User.new
      @devise_mapping = Devise.mappings[:user]
    end
  end
  
  helper_method :resource, :resource_name, :devise_mapping
  
  private
  
  def resource_name
    :user
  end
  
  def resource
    @resource ||= User.new
  end
  
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end