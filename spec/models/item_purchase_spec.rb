require 'rails_helper'
RSpec.describe ItemPurchase, type: :model do
  before do
    @item_purchase = FactoryBot.build(:item_purchase)
  end
  describe '商品購入'do
    context '購入がうまくいくとき' do
      it '建物名以外の情報全てが存在するとき' do
        expect(@item_purchase).to be_valid
      end
    end

    context '購入ができないとき' do
      it 'クレジットカードの情報が空では購入できない' do
        @item_purchase.token = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空では購入できない' do
        @item_purchase.postal_code = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it '都道府県が空では購入できない' do
        @item_purchase.prefecture_id = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Prefecture お届け先の都道府県を選択してください")
      end
      it '市区町村が空では購入できない' do
        @item_purchase.municipalities = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Municipalities can't be blank")
      end
      it '番地が空では購入できない' do
        @item_purchase.address = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空では購入できない' do
        @item_purchase.phone_number = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it '郵便番号に[-]がなければ購入できない' do
        @item_purchase.postal_code = 1234567
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Postal code 郵便番号は半角数字でハイフンを含めてください")
      end
      it '郵便番号は半角数字でなければ購入できない' do
        @item_purchase.postal_code = '１２３４５６７'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Postal code 郵便番号は半角数字でハイフンを含めてください")
      end
      it '都道府県が[--]では購入できない' do
        @item_purchase.prefecture_id = 0
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Prefecture お届け先の都道府県を選択してください")
      end
      it '電話番号に[-]があると購入できない' do
        @item_purchase.phone_number = '123-4567'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Phone number 電話番号はハイフン無しで入力")
      end
    end
  end
end




