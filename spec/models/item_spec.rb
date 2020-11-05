require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品'do
    context '出品がうまくいくとき' do
      it '商品情報が全て存在していれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '出品がうまくいかないとき' do
      it '出品画像がないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名がないと出品できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '説明がないと出品できない' do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it 'カテゴリーが選択されていないと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '状態が選択されていないと出品できない' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料について選択されていないと出品できない' do
        @item.shipping_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping can't be blank")
      end
      it '発送元について選択されていないと出品できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送日について選択されていないと出品できない' do
        @item.dispatch_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Dispatch can't be blank")
      end
      it '価格について選択されていないと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格設定が範囲外だと出品できない(300円未満の時)' do
        @item.price = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Price 半角数字で入力！¥300~¥9999999の範囲で入力")
      end
      it '価格設定が範囲外だと出品できない(9999999円超過の時)' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price 半角数字で入力！¥300~¥9999999の範囲で入力")
      end
    end
  end
end
