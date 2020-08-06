# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association
- has_many :items
- has_many :buyers

## items テーブル

| Column   | Type    | Options     |
| -------- | ------- | ----------- |
| name     | string  | null: false |
| image    | text    | null: false |
| content  | text    | null: false |
| category | integer | null: false |
| status   | integer | null: false |
| user_id  | integer | null: false |

### Association
- belongs_to :user
- has_one :buyer

## buyers テーブル

| Column      | Type    | Options     |
| ----------- | ------- | ----------- |
| card_number | integer | null: false |
| address     | text    | null: false |
| user_id     | integer | null: false |
| item_id     | integer | null: false |

### Association
- belongs_to :item
- belongs_to :user