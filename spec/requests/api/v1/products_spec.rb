# frozen_string_literal: true

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'GET /products' do
    let!(:available_products) { FactoryBot.create_list(:product, 2) }
    let!(:disabled_products) { FactoryBot.create(:product, :disabled) }

    it 'retrieves available products' do
      get '/api/v1/products'
      expect(response.body).to eq(ActiveModelSerializers::SerializableResource.new(available_products).to_json)
    end
  end

  describe 'POST /products' do
    context 'when request is invalid' do
      it 'responds with 400' do
        post '/api/v1/products', params: { product: { name: 'banjo' } }
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)['errors']).to be_present
      end
    end

    context 'when request is valid' do
      it 'creates the product' do
        uuid = '1dea0d8d-8362-4f74-8dd4-7466558f1d32'
        post '/api/v1/products', params: { product: { name: 'Banjo', uuid: uuid, price: 199.99 } }
        expect(response.status).to eq(201)
        created_product = Product.last
        expect(JSON.parse(response.body)['id']).to eq(created_product.id)
        expect(JSON.parse(response.body)['uuid']).to eq(uuid)
        expect(created_product.available).to be_truthy
      end
    end
  end

  describe 'DELETE /products/:id' do
    context 'when product does not exist' do
      it 'responds with 404' do
        delete '/api/v1/products/1'
        expect(response.status).to eq(404)
      end
    end

    context 'when product exists' do
      let!(:product) { FactoryBot.create(:product) }

      it 'creates the product' do
        delete "/api/v1/products/#{product.id}"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['success']).to be_truthy
      end
    end
  end
end
