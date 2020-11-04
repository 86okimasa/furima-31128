class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
  end


  private

  def message_params
    params.require(:item).permit(:image).merge(user_id: current_user.id)
  end

end
