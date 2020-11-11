class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id || @item.purchase.valid?
      redirect_to root_path
    end

    @item_purchase = ItemPurchase.new
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
      if @item_purchase.valid?
        pay_item
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

    def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: purchase_params[:price],  # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
    end

end
