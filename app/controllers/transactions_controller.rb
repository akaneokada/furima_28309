class TransactionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :ensure_correct_item, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @buyer = ItemBuyer.new
  end

  def create
    @item = Item.find(params[:item_id])
    @buyer = ItemBuyer.new(buyer_params)
    if @buyer.valid?
      pay_item
      @buyer.save
      return redirect_to root_path
    else
      render :index
    end
  end
  
  private
  
  def buyer_params
    params.permit(:price, :token, :postal_code, :prefecture, :city,
                  :house_number, :building_name, :phone_number, :item_id).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: buyer_params[:price],
      card: buyer_params[:token],
      currency:'jpy'
    )
  end

  def ensure_correct_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.buyer
  end
end