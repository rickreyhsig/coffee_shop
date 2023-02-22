json.extract! order_item, :id, :item_id, :order_id, :quantity, :created_at, :updated_at
json.url order_item_url(order_item, format: :json)
