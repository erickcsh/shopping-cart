# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :user_shopping_cart
  has_many :shopping_cart_products, through: :user_shopping_cart, source: :product

  validates :username, presence: true, uniqueness: true
end
