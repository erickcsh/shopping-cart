# Shopping Cart

Dev test project for shopping cart API.

## Setup

Make sure you have docker and docker-compose installed.

1. Build the project: `docker-compose build`
2. Start the server: `docker-compose up`
3. Setup the database `docker-compose run web rails db:create db:migrate db:seed`
4. Server is up and ready. Next time you need to start up the server, you only need to run step 2


## Test

To run tests execute: `docker-compose run web rspec spec`

## Example curls

### List items for sale

### List a new item

### Unlist an item

### Add item to cart

### Remove item from cart

### View user's cart