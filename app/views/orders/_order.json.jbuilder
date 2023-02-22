json.extract! order, :id, :customer_id, :order_total, :discount, :created_at, :updated_at
json.url order_url(order, format: :json)
