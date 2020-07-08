module Api
  module V1
    class ProductsController < Api::ApiController
      def index
        products = Product.where(available: true)
        render json: products, each_serializer: ProductSerializer
      end

      def create
        product = Product.new(product_params)
        product.available = true
        if product.save
          render json: product, serializer: ProductSerializer, status: 201
        else
          render json: { errors: product.errors }, status: 400
        end
      end

      def destroy
        product = Product.find(params[:id])
        if product.destroy
          render json: { success: true }
        else
          render json: { errors: product.errors }, status: 400
        end
      end

      private

      def product_params
        params.require(:product).permit(:name, :uuid, :price)
      end
    end
  end
end
