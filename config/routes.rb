# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :create, :destroy]

      get '/user/:user_id/shopping_cart/', to: 'user_shopping_carts#show'
      post '/user/:user_id/shopping_cart/:product_id', to: 'user_shopping_carts#create'
      delete '/user/:user_id/shopping_cart/:product_id', to: 'user_shopping_carts#delete'
    end
  end
end
