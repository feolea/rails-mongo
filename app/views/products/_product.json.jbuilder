json.extract! product, :sku, :name, :description, :price, :quantity
json.url product_url(product, format: :json)
