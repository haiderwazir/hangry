class MenuItemsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :check_moo, only: [:new, :show, :create, :update, :destroy]
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]
  
  # GET /menu_items
  # GET /menu_items.json
  def index
    @menu_items = MenuItem.all
    respond_with @menu_items, status: 200
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
    respond_with @menu_item, status: 200
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new

    respond_with @menu_item, status: 200
  end

  # GET /menu_items/1/edit
  def edit
    respond_with @menu_item, status: 200
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      respond_with @menu_item, status: 200
    else
      render :json => {:error => 'Internal Server Error', :message => 'Menu item could not be created.'}, status: 500
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update
    if @menu_item.update(menu_item_params)
      respond_with @menu_item, status: 200
    else
     render json: @menu_item.errors, status: :unprocessable_entity 
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    
    if @menu_item.destroy
      render :json => {:message => 'Item successfully deleted!'}, status: 200
    else
      render :json => {:error => 'Internal Server Error', :message => 'Item could not be deleted.'}, status: 500
    end
  end

  def today
    @menu_items= MenuItem.get_today

    respond_with @menu_items, status: 200
  end

  def import
    file = params['file']
    MenuItem.import_items(file)

    respond_to do |format|
      format.html { redirect_to menu_items_url, notice: 'Menu items successfully imported!' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :description, :price, { :flavors=> [] }, :pictureUrl)
    end
end
