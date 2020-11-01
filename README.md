# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false,              |
| encrypted_password | string | null: false               |
| email              | string | null: false, unique: true |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_kana        | string | null: false               |
| first_kana         | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| name         | string     | null: false       |
| explanation  | text       | null: false       |
| category_id  | integer    | null: false       |
| condition_id | integer    | null: false       |
| shipping_id  | integer    | null: false       |
| publisher_id | integer    | null: false       |
| dispatch_id  | integer    | null: false       |
| price        | integer    | null: false       |
| user         | references | foreign_key: true |

### Association

- has_one :purchase
- belongs_to :user

## purchases テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| user          | references | foreign_key: true |
| item          | references | foreign_key: true |
 
### Association

- belongs_to :user
- belongs_to :item
- has_one    :purchaser

## purchasers

 Column          | Type       | Options           |
| -------------- | ---------- | ----------------- |
| postal_code    | string     | null: false       |
| prefecture_id  | integer    | null: false       |
| municipalities | string     | null: false       |
| address        | string     | null: false       |
| building       | string     |                   |
| number         | string     | null: false       |
| purchase       | references | foreign_key: true |

### Association

- belongs_to :purchase

