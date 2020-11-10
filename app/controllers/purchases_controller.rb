class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @item_purchase = ItemPurchase.new
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
      if @item_purchase.valid?
      Payjp.api_key = "sk_test_17efb7ed25673a19bd80a8d2"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: purchase_params[:price],  # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
        @item_purchase.save
        redirect_to root_path
      else
        @item = Item.find(params[:item_id])
        render :index
      end
  end


  private
    def purchase_params
      @item = Item.find(params[:item_id])
      params.require(:item_purchase).permit(:postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number).merge(token: params[:token], price: @item.price, item_id: @item.id, user_id: current_user.id)
    end

end
