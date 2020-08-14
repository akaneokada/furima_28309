class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.includes(:buyer).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    if current_user.id == @item.user.id
      @item.destroy
      redirect_to root_path
    else
      redirect_to item_path(params[:id])
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