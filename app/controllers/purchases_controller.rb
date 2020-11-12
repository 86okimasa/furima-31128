class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :item_find, only: [:index, :create]

  def index
    if @item.user_id == current_user.id || @item.purchase != nil
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
        render :index
      end
  end


  private

    def purchase_params
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

    def item_find
      @item = Item.find(params[:item_id])
    end

end
