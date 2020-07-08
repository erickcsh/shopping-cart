# == Schema Information
#
# Table name: user_shopping_carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_shopping_carts_on_product_id  (product_id)
#  index_user_shopping_carts_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserShoppingCart, type: :model do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:product) }
end
