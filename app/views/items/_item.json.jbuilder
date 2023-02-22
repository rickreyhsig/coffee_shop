json.extract! item, :id, :description, :price, :tax_rate, :created_at, :updated_at
json.url item_url(item, format: :json)
