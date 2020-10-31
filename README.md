# テーブル設計

## users テーブル

| Column      | Type   | Options                   |
| ----------- | ------ | ------------------------- |
| nickname    | string | null: false, unique: true |
| password    | string | null: false               |
| email       | string | null: false, unique: true |
| family_name | string | null: false               |
| first_name  | string | null: false               |
| family_kana | string | null: false               |
| first_kana  | string | null: false               |
| year        | date   | null: false               |
| month       | date   | null: false               |
| day         | date   | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column      | Type       | Options     |
| ----------- | ---------- | ----------- |
| name        | string     | null: false |
| explanation | text       | null: false |
| category    | string     | null: false |
| condition   | string     | null: false |
| shipping    | string     | null: false |
| publisher   | string     | null: false |
| dispatch    | string     | null: false |
| price       | string     | null: false |
| image       |            |             |
| user        | references |             |

### Association

- has_one :purchase
- belongs_to :user

## purchases テーブル

| Column        | Type       | Options |
| ------------- | ---------- | ------- |
| purchase_date | timestamp  |         |
| user          | references |         |
| item          | references |         |
 
### Association

- belongs_to :user
- belongs_to :item
- has_one    :purchaser

## purchasers

 Column          | Type       | Options     |
| -------------- | ---------- | ----------- |
| postal_code    | integer    | null: false |
| prefectures    | string     | null: false |
| municipalities | string     | null: false |
| address        | integer    | null: false |
| building       | string     |             |
| number         | integer    | null: false |
| purchase       | references |             |

### Association

-belongs_tp :purchase

