class ItemsController < ApplicationController
  before_action :move_to_index, only: :new

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def item_params
    params.require(:item).permit(
      :name, :image, :content, :category_id, :status_id, :price,
      :delivery_fee_id, :shipping_region_id, :days_until_shipping_id
    ).merge(user_id: current_user.id)
  end
end
