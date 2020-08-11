FactoryBot.define do
  factory :item do
    name                   { Faker::Lorem.sentence}
    content                { Faker::Lorem.sentence}
    category_id            { Faker::Number.within(range: 2..11)}
    status_id              { Faker::Number.within(range: 2..7)}
    price                  { Faker::Number.within(range: 300..9999999)}
    delivery_fee_id        { Faker::Number.within(range: 2..3)}
    shipping_region_id     { Faker::Number.within(range: 2..48)}
    days_until_shipping_id { Faker::Number.within(range: 2..4)}
    association :user
  end
end
