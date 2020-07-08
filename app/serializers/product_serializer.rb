# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :name, :price
end
