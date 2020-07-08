# frozen_string_literal: true

RSpec.describe 'Api::V1::UserShoppingCarts', type: :request do
  let!(:user) { FactoryBot.create(:user) }

  describe 'GET /user/:user_id/shopping_cart' do
    let!(:product_1) { FactoryBot.create(:product) }
    let!(:product_2) { FactoryBot.create(:product) }
    let!(:shopping_cart_entry_1) { FactoryBot.create(:user_shopping_cart, user: user, product: product_1) }
    let!(:shopping_cart_entry_2) { FactoryBot.create(:user_shopping_cart, user: user, product: product_2) }

    it 'retrieves all items in cart' do
      get "/api/v1/user/#{user.id}/shopping_cart"
      expect(response.body).to eq(ActiveModelSerializers::SerializableResource.new([product_1, product_2]).to_json)
    end
  end

  describe 'POST /user/:user_id/shopping_cart/:product_id' do
    context 'when product is disabled' do
      let!(:product) { FactoryBot.create(:product, :disabled) }

      it 'responds with 400 and does not add to the cart' do
        post "/api/v1/user/#{user.id}/shopping_cart/#{product.id}"
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)['errors']).to eq('Product not available')
        expect(user.user_shopping_cart).to be_empty
      end
    end

    context 'when product does not exist' do
      it 'responds with 400 and does not add to the cart' do
        post "/api/v1/user/#{user.id}/shopping_cart/1"
        expect(response.status).to eq(404)
        expect(user.user_shopping_cart).to be_empty
      end
    end

    context 'when disable fails' do
      let!(:product) { FactoryBot.create(:product) }

      it 'responds with 400 and does not add to the cart' do
        allow(product).to receive(:disable!).and_raise(ActiveRecord::RecordInvalid)
        allow(Product).to receive(:find).with(product.id.to_s).and_return(product)
        post "/api/v1/user/#{user.id}/shopping_cart/#{product.id}"
        allow(Product).to receive(:find).and_call_original
        expect(response.status).to eq(400)
        expect(user.user_shopping_cart).to be_empty
        expect(product.reload.available).to be_truthy
      end
    end

    context 'when request is valid' do
      let!(:product) { FactoryBot.create(:product) }

      it 'adds the product to the cart and disables it' do
        post "/api/v1/user/#{user.id}/shopping_cart/#{product.id}"
        expect(response.status).to eq(201)
        expect(product.reload.available).to be_falsey
        expect(user.shopping_cart_products).to match([product])
      end
    end
  end

  describe 'DELETE /products/:id' do
    context 'when product is not in cart' do
      it 'responds with 400' do
        delete "/api/v1/user/#{user.id}/shopping_cart/3"
        expect(response.status).to eq(404)
      end
    end

    context 'when enable fails' do
      let!(:product) { FactoryBot.create(:product, :disabled) }
      let!(:shopping_cart_entry) { FactoryBot.create(:user_shopping_cart, user: user, product: product) }

      it 'responds with 400 and does not remove from cart' do
        allow(product).to receive(:enable!).and_raise(ActiveRecord::RecordInvalid)
        allow(Product).to receive(:find).with(product.id.to_s).and_return(product)
        delete "/api/v1/user/#{user.id}/shopping_cart/#{product.id}"
        allow(Product).to receive(:find).and_call_original
        expect(response.status).to eq(400)
        expect(product.reload.available).to be_falsey
        expect(user.shopping_cart_products).to match([product])
      end
    end

    context 'when request is valid' do
      let!(:product_1) { FactoryBot.create(:product, :disabled) }
      let!(:product_2) { FactoryBot.create(:product, :disabled) }
      let!(:shopping_cart_entry_1) { FactoryBot.create(:user_shopping_cart, user: user, product: product_1) }
      let!(:shopping_cart_entry_2) { FactoryBot.create(:user_shopping_cart, user: user, product: product_2) }

      it 'removes the product from the cart and enables it' do
        delete "/api/v1/user/#{user.id}/shopping_cart/#{product_1.id}"
        expect(response.status).to eq(200)
        expect(product_1.reload.available).to be_truthy
        expect(user.shopping_cart_products).to match([product_2])
      end
    end
  end
end
