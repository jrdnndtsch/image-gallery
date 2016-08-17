ShopifyApp.configure do |config|
  config.api_key = ENV['api_key']
  config.secret = ENV['api_secret']
  config.redirect_uri = "http://localhost:3000/auth/shopify/callback"
  config.scope = "read_orders, read_products, write_products"
  config.embedded_app = true
end