class OrdersController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy, :reorder]

  

  # GET /orders
  # GET /orders.json
  def index
    @user= User.find(params['user_id']) rescue nil
    @user ||= current_user
    @orders = @user.orders.placed.desc(:created_at)

    respond_with @orders, status: 200
  end

  # POST /orders
  # POST /orders.json
  def create
    begin
      @order = current_user.orders.find(params['order_id'])
    rescue
      @order = current_user.orders.create
    end

    @order.add_item(params['item_id'], params['flavor'])

    respond_with @order, status: 200
  end


  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order.update(order_params)
    
    respond_with @order, status: 200
  end

  def remove_item
    @order = current_user.orders.find(params['order_id'])
    @order.remove_item(params['item_id'])

    respond_with @order
  end

  def reorder
    Order.reorder(@order, current_user)

    respond_with @order, status: 200
  end

  def confirm
    @order = current_user.orders.find(params['order_id'])
    @order.confirm
    
    respond_with @order
  end

  def destroy
    if @order.destroy
      render :json => {:message => 'Order successfully deleted!'}, status: 200
    else
      render :json => {:error => 'Internal Server Error', :message => 'Order could not be deleted.'}, status: 500
    end
  end

  def today
    @orders= Order.where(created_at: (Time.now - 24.hours)..Time.now).desc(:created_at)

    respond_with @orders, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:items, :price)
    end
end
