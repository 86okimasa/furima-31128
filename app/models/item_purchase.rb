class ItemPurchase
  
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :price, :postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number, :token, :purchase_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :municipalities
    validates :address
    validates :phone_number, numericality: { only_integer: true, message: "is invalid. Input half-width characters." }
  end

  def save
    @purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Purchaser.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building: building, phone_number: phone_number, purchase_id: @purchase.id)
  end
end
