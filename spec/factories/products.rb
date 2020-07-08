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
FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    price { "#{rand(999)}.#{rand(10)}".to_f }
    uuid { Faker::Internet.uuid }
    available { true }

    trait :disabled do
      available { false }
    end
  end
end
