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
require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { create(:product) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:uuid) }
  it { should validate_uniqueness_of(:uuid) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than(0) }

  describe '.enable!' do
    subject { FactoryBot.create(:product, :disabled) }

    it 'marks it as available' do
      subject.enable!
      expect(subject.available).to be_truthy
    end
  end

  describe '.disable!' do
    subject { FactoryBot.create(:product) }

    it 'marks it as available' do
      subject.disable!
      expect(subject.available).to be_falsey
    end
  end
end
