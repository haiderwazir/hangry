class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy, :reorder]

  # GET /orders
  # GET /orders.json
  def index
    @user= User.find(params['user_id']) rescue nil
    @user ||= current_user
    @orders = @user.orders.placed.desc(:created_at)
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
    

    respond_to do |format|
      format.js
    end

  end

  def users
    @users= User.all
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  

  def remove_item
    @order = current_user.orders.find(params['order_id'])
    @order.remove_item(params['item_id'])

    respond_to do |format|
      format.js 
    end

  end

  def reorder
    Order.reorder(@order, current_user)

    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order Successfully Placed!' }
    end
  end

  def confirm
    @order = current_user.orders.find(params['order_id'])
    @order.confirm
    
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order Successfully Placed!' }
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to menu_items_url, notice: 'Order Cancelled!' }
    end
  end

  def today
    @orders= Order.where(created_at: (Time.now - 24.hours)..Time.now).desc(:created_at)
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
