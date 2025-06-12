# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create roles
%w[admin seller].each do |role|
  Role.find_or_create_by(name: role)
end

# Create admin user
admin = User.find_or_create_by(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end
admin.add_role(:admin) unless admin.admin?

# Create seller user
seller = User.find_or_create_by(email: 'seller@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end
seller.add_role(:seller) unless seller.seller?

# Create categories
categories = ['Electronics', 'Clothing', 'Food', 'Furniture', 'Books']
categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

# Create products
if Product.count.zero?
  Category.all.each do |category|
    5.times do |i|
      Product.create!(
        name: "#{category.name} Product #{i + 1}",
        size: ['Small', 'Medium', 'Large'].sample,
        quantity: rand(5..100),
        purchase_price: rand(10.0..50.0).round(2),
        selling_price: rand(15.0..75.0).round(2),
        category: category,
        low_stock_threshold: rand(5..20)
      )
    end
  end
end

# Create daily sales
if DailySale.count.zero?
  30.times do |i|
    date = (30 - i).days.ago.to_date
    Product.all.sample(rand(3..8)).each do |product|
      quantity_sold = rand(1..[product.quantity, 10].min)
      DailySale.create!(
        product: product,
        quantity_sold: quantity_sold,
        date: date,
        created_by: [admin, seller].sample
      )
    end
  end
end

puts "Seeds completed successfully!"
