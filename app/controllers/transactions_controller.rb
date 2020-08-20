class TransactionsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @buyer = Buyer.new(price: buyer_params[:price], item_id: buyer_params[:item_id], user_id: current_user.id)
    if @buyer.valid?
      pay_item
      @buyer.save
      return redirect_to root_path
    else
      render 'index'
    end
  end
  
  private
  
  def buyer_params
    params.permit(:price, :token, :item_id)
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: buyer_params[:price],
      card: buyer_params[:token],
      currency:'jpy'
    )
  end
end