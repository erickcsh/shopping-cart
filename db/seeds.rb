# frozen_string_literal: true

User.create(username: 'john_lennon', name: 'John')
User.create(username: 'ringo_starr', name: 'Ringo')

Product.create(name: 'Stratoscaster guitar', uuid: '09189731-aef8-450f-b343-1e16d10e5353', available: true, price: 999.99)
Product.create(name: 'Yamaha drums', uuid: 'efa12e73-23a6-4bb3-bcbe-3e33e88e7dd5', available: true, price: 2455.99)
Product.create(name: 'Piano', uuid: '051960b2-e3bc-400e-a9e7-39472c2c3886', available: true, price: 10000.99)
