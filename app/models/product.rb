# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  available  :boolean          default(TRUE), not null
#  name       :string           not null
#  price      :decimal(, )      not null
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product < ApplicationRecord
  validates :name, presence: true
  validates :uuid, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  def disable!
    update(available: false)
  end

  def enable!
    update(available: true)
  end
end
