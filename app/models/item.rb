class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :buyer

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :shipping_region
  belongs_to_active_hash :days_until_shipping

  with_options presence: true do
    validates :name
    validates :image
    validates :content
    validates :category
    validates :status
    validates :price
    validates :delivery_fee
    validates :shipping_region
    validates :days_until_shipping
  end

  # 選択が「---」の場合は保存できないようにする
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :shipping_region_id
    validates :days_until_shipping_id
  end

  # 価格が300円以下、9,999,999円以上の場合は保存できないようにする
  validates :price, numericality: {
    only_integer: true,
    greater_than: 300, less_than: 9_999_999
  }
end
