# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| name             | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | date   | null: false |

### Association
- has_many :items
- has_many :buyers

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| image               | text       | null: false                    |
| content             | text       | null: false                    |
| category            | integer    | null: false                    |
| status              | integer    | null: false                    |
| price               | integer    | null: false                    |
| delivery_fee        | integer    | null: false                    |
| shipping_region     | integer    | null: false                    |
| days_until_shipping | integer    | null: false                    |
| user_id             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :buyer
- has_one :address

## buyers テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |
| price   | integer    | null: false                    |

### Association
- belongs_to :item
- belongs_to :user

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture    | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| item_id       | references | null: false, foreign_key: true |

- belongs_to :item

