# Shopping Cart

Dev test project for shopping cart API.

## Repo

https://github.com/erickcsh/shopping-cart

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

Request:
```
curl -X GET \
  http://localhost:3000/api/v1/products \
  -H 'cache-control: no-cache' \
  -H 'postman-token: 4efd879c-7747-08c2-0e6b-7afb41ee0839'
```
Example response:
```
[
    {
        "id": 1,
        "uuid": "09189731-aef8-450f-b343-1e16d10e5353",
        "name": "Stratoscaster guitar",
        "price": "999.99"
    },
    {
        "id": 2,
        "uuid": "efa12e73-23a6-4bb3-bcbe-3e33e88e7dd5",
        "name": "Yamaha drums",
        "price": "2455.99"
    },
    {
        "id": 3,
        "uuid": "051960b2-e3bc-400e-a9e7-39472c2c3886",
        "name": "Piano",
        "price": "10000.99"
    }
]
```

### List a new item

Request:
```
curl -X POST \
  http://localhost:3000/api/v1/products \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 30c2c218-d8b6-4674-e084-3afe3131b307' \
  -d '{
	"product": {
		"name": "Bass",
		"price": 599.11,
		"uuid": "249a3540-ee93-4a1e-a94c-3603da707758"
	}
}'
```

Example response:
```
{
    "id": 4,
    "uuid": "249a3540-ee93-4a1e-a94c-3603da707758",
    "name": "Bass",
    "price": "599.11"
}
```

### Unlist an item

Request:
```
curl -X DELETE \
  http://localhost:3000/api/v1/products/3 \
  -H 'accept: application/json' \
  -H 'cache-control: no-cache' \
  -H 'postman-token: 734a3b79-8203-f7a3-3abf-bc9c114e1878'
```

Example response:
```
{
    "success": true
}
```

### Add item to cart

Url params:
/user/<user_id>/shopping_cart/<product_id>

NOTE: Since there is no login in functionality, retrieve the user id from the DB. Product ID can be retrieved from the list products endpoint.

Request:
```
curl -X POST \
  http://localhost:3000/api/v1/user/1/shopping_cart/4 \
  -H 'cache-control: no-cache' \
  -H 'postman-token: ef8e4d43-0df4-0ca3-0ec8-48d159662a4e'
```

Example response:
```
{
    "success": true
}
```

### Remove item from cart

Url params:
/user/<user_id>/shopping_cart/<product_id>

NOTE: Since there is no login in functionality, retrieve the user id from the DB. Product ID can be retrieved from the list products endpoint.

Request:
```
curl -X DELETE \
  http://localhost:3000/api/v1/user/1/shopping_cart/4 \
  -H 'cache-control: no-cache' \
  -H 'postman-token: bc3c4b0e-992b-2673-c51f-c9d267af1de2'
```

Example response:
```
{
    "success": true
}
```

### View user's cart

Url params:
/user/<user_id>/shopping_cart

NOTE: Since there is no login in functionality, retrieve the user id from the DB. 

Request:
```
curl -X GET \
  http://localhost:3000/api/v1/user/1/shopping_cart \
  -H 'accept: application/json' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 709f06de-1912-d884-e4ed-79fd92e60b78' \
  -d '{
	"website": { "url": "https://www.facebook.com/ErickCQ1" }
}'
```

Example response:
```
[
    {
        "id": 4,
        "uuid": "249a3540-ee93-4a1e-a94c-3603da707758",
        "name": "Bass",
        "price": "599.11"
    }
]
```

## TODOs

Since this is a test project some regular features were left behind:

- User model does not have a password. There is no way to log in. User is send as part of the body in create requests, but it should use a token with JWTm OAuth or similar.
- There is no pagination in list products. Need to be added for performance.
- When adding to cart a lock can be used to make sure 2 users do not add the same product at once
- Validate the logged in user is the one modifying its own cart only
- Rails creates many files by default, there is some cleanup that can be done
- Create a database.yml.example and remove database.yml from repo