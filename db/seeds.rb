puts "Clearing existing data..."
PriceRecord.destroy_all
Product.destroy_all

puts "Creating products..."
products_data = [
  { name: "Apple iPhone 15 Pro", category: "Electronics", description: "6.1-inch Super Retina XDR display, A17 Pro chip, titanium design, 48MP camera system" },
  { name: "Samsung 65\" 4K QLED TV", category: "TVs & Home Theater", description: "65-inch QLED 4K Smart TV with Quantum HDR, Motion Xcelerator, and built-in Alexa" },
  { name: "Sony WH-1000XM5 Headphones", category: "Electronics", description: "Industry-leading noise canceling wireless headphones, 30-hour battery life" },
  { name: "Apple MacBook Air M2", category: "Computers & Laptops", description: "13.6-inch Liquid Retina display, Apple M2 chip, 8GB RAM, 256GB SSD" },
  { name: "PlayStation 5 Console", category: "Gaming", description: "Next-gen gaming console, 4K gaming, ray tracing, ultra-high speed SSD" },
  { name: "Dyson V15 Detect Vacuum", category: "Appliances", description: "Cordless vacuum with laser dust detection, HEPA filtration, 60 min run time" },
  { name: "Nike Air Max 270", category: "Clothing & Shoes", description: "Men's shoe with Max Air unit for all-day comfort, available in multiple colorways" },
  { name: "Atomic Habits by James Clear", category: "Books", description: "An Easy & Proven Way to Build Good Habits & Break Bad Ones — #1 NY Times Bestseller" },
  { name: "Kindle Paperwhite (16GB)", category: "Electronics", description: "The thinnest, lightest Kindle Paperwhite yet, waterproof, 3-month free Kindle Unlimited" },
  { name: "Instant Pot Duo 7-in-1", category: "Appliances", description: "7-in-1 electric pressure cooker, slow cooker, rice cooker, steamer, sauté, yogurt maker, warmer" }
]

products = products_data.map { |p| Product.create!(p) }

puts "Creating price records..."
store_urls = {
  "Amazon"      => "https://www.amazon.com",
  "Walmart"     => "https://www.walmart.com",
  "Target"      => "https://www.target.com",
  "Best Buy"    => "https://www.bestbuy.com",
  "Costco"      => "https://www.costco.com",
  "eBay"        => "https://www.ebay.com",
  "Newegg"      => "https://www.newegg.com",
  "Apple Store" => "https://www.apple.com/shop"
}

price_ranges = {
  "Apple iPhone 15 Pro"         => [949, 1199],
  "Samsung 65\" 4K QLED TV"    => [799, 1299],
  "Sony WH-1000XM5 Headphones" => [279, 399],
  "Apple MacBook Air M2"        => [999, 1299],
  "PlayStation 5 Console"       => [449, 549],
  "Dyson V15 Detect Vacuum"     => [649, 799],
  "Nike Air Max 270"            => [89, 150],
  "Atomic Habits by James Clear"=> [11, 27],
  "Kindle Paperwhite (16GB)"    => [99, 149],
  "Instant Pot Duo 7-in-1"     => [59, 99]
}

notes_options = ["Black Friday deal", "Holiday sale", "Limited time offer", "Coupon applied: SAVE10", "Regular price", "Clearance", ""]

products.each do |product|
  range = price_ranges[product.name] || [50, 500]
  stores = store_urls.keys.sample(3)

  stores.each_with_index do |store, i|
    price = rand(range[0]..range[1]) + rand(0..99) / 100.0
    PriceRecord.create!(
      product: product,
      price: price,
      store_name: store,
      url: "#{store_urls[store]}/search?q=#{product.name.gsub(' ', '+')}",
      recorded_at: (i * 10 + rand(1..9)).days.ago,
      notes: notes_options.sample
    )
  end
end

puts "✅ Done! Created #{Product.count} products and #{PriceRecord.count} price records."