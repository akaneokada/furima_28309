FactoryBot.define do
  factory :item_buyer do
    token         { Faker::Lorem.characters }
    postal_code   { '123-4567' }
    prefecture    { 1 }
    city          { '函館市' }
    house_number  { '1-1-1' }
    building_name { '第1ビル' }
    phone_number  { '09012345678' }
    user_id       { 1 }
    item_id       { 1 }
  end
end
