class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @items = Item.order("updated_at DESC")
    @purchases = Purchase.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @purchases = Purchase.all
  end

  def edit
  end

  def destroy
    @item = Item.find(params[:id])
    if current_user.id == @item.user_id
      if @item.destroy
        redirect_to root_path
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :condition_id, :shipping_id, :prefecture_id, :dispatch_id, :price, :image, ).merge(user_id: current_user.id)
  end

end
