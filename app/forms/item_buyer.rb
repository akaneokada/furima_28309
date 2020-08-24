class ItemBuyer
  include ActiveModel::Model
  attr_accessor :price, :token, :item_id, :user_id, :postal_code, :prefecture, :city, :house_number, :building_name, :phone_number

  POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}\z/.freeze

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: POSTAL_CODE_REGEX, message: 'Input correctly' }
    validates :prefecture
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    Buyer.create(price: price, user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number, item_id: item_id)
  end
end
