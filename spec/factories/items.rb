FactoryBot.define do
  factory :item do
    images                 { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_image.png'),
                              'image/png')] }
    name                   { 'オムライス' }
    content                { 'オムライスです' }
    category_id            { 2 }
    status_id              { 2 }
    price                  { 1000 }
    delivery_fee_id        { 2 }
    shipping_region_id     { 2 }
    days_until_shipping_id { 2 }
    association :user
  end
end
