class Customer < ApplicationRecord
  validates :name, presence: true
  has_many :orders
end


# POST /customers 
# JSON 
=begin
{"customer": {"name": "Joana Kreyhsig"}}
=end

# POST /orders/new?customer_id=2
# JSON
=begin
{"customer_id":"4", "order_items_attributes":{"0": {"item_id":"1", "quantity":"2"}, "1":{"item_id":"2", "quantity":"2"}, "2":{"item_id":"3", "quantity":"3"}}}
=end


