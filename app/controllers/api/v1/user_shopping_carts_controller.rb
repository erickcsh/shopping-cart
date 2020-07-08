module Api
  module V1
    class UserShoppingCartsController < Api::ApiController
      before_action :find_user

      def show
        products = @user.shopping_cart_products
        render json: products, each_serializer: ProductSerializer
      end

      def create
        @product = Product.find(params[:product_id])
        render(json: { errors: 'Product not available' }, status: 400) and return unless @product.available

        @shopping_cart_entry = UserShoppingCart.new(product: @product, user: @user)
        add_product_to_cart
      end

      def delete
        @product = Product.find(params[:product_id])
        @shopping_cart_entry = UserShoppingCart.find_by!(product: @product, user: @user)
        delete_product_from_cart
      end

      private

      def add_product_to_cart
        ActiveRecord::Base.transaction do
          @shopping_cart_entry.save!
          @product.disable!
        end
        render json: { sucess: true }, status: 201
      rescue ActiveRecord::RecordInvalid
        render json: { errors: @shopping_cart_entry.errors }, status: 400
      end

      def delete_product_from_cart
        ActiveRecord::Base.transaction do
          @shopping_cart_entry.destroy!
          @product.enable!
        end
        render json: { sucess: true }
      rescue ActiveRecord::RecordInvalid
        render json: { errors: @shopping_cart_entry.errors }, status: 400
      end
    end
  end
end
