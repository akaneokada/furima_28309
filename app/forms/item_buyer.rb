class ItemBuyer
  include ActiveModel::Model
  attr_accessor :price, :token, :item_id, :user_id, :postal_code, :prefecture, :city, :house_number, :building_name, :phone_number

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly' }
    validates :prefecture, numericality: { other_than: 0, message: 'Select' }
    validates :city
    validates :house_number
    validates :phone_number, length: { maximum: 11 }
  end

  def save
    Buyer.create(price: price, user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number, item_id: item_id)
  end
end
