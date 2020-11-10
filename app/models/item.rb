class Item < ApplicationRecord 
  with_options presence: true do
    validates :image
    validates :name
    validates :explanation
    validates :category_id
    validates :condition_id
    validates :shipping_id
    validates :prefecture_id
    validates :dispatch_id
    validates :price
  end

  validates :price, numericality: { with: /\A[0-9]+\z/, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "半角数字で入力！¥300~¥9999999の範囲で入力"}

  belongs_to :user
  has_one_attached :image
  has_one :purchaser

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping
  belongs_to :prefecture
  belongs_to :dispatch

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :condition_id
    validates :shipping_id
    validates :prefecture_id
    validates :dispatch_id
  end
end
