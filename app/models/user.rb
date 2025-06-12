class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 rolify

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
