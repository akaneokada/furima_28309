class ItemsController < ApplicationController

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
  def item_params
    params.require(:item).permit(
      :name, :image, :content, :category_id, :status_id, :price,
      :delivery_fee_id, :shipping_region_id, :days_until_shipping_id
    ).merge(user_id: current_user.id)
  end

end
