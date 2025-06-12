class AdminMailer < ApplicationMailer
  def low_stock_alert(product)
    @product = product
    admins = User.with_role(:admin)
    
    admins.each do |admin|
      mail(to: admin.email, subject: "Low Stock Alert: #{product.name}")
    end
  end
end