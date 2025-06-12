class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  rolify
  has_many :daily_sales, foreign_key: 'created_by_id', dependent: :nullify
  has_many :products, through: :daily_sales
  has_many :created_daily_sales, class_name: 'DailySale', foreign_key: 'created_by_id', dependent: :nullify

  after_create :assign_default_role

  def assign_default_role
    add_role(:seller) if roles.blank?
  end

  def admin?
    has_role?(:admin)
  end

  def seller?
    has_role?(:seller)
  end
end
