class Order
  include Mongoid::Document
  include Mongoid::Timestamps


  # field :items, type: Array, default: []
  # field :price, type: Money, default: 0
  field :is_placed?, type: Boolean, default: false

  belongs_to :user
  has_many :order_items, :dependent => :destroy

  scope :placed, ->{where(is_placed?: true)}


  def get_price
  	self.order_items.sum(&:price)
	end 

	def add_item(item_id, flavor)
		@new_item= MenuItem.find(item_id)
		flavor= @new_item.flavors.sample if flavor == "random"
    @new_order_item = self.order_items.new price: @new_item.price, flavor: flavor
    @new_order_item.menu_item = @new_item
    @new_order_item.save!
  end

  def remove_item(item_id)
  	OrderItem.find(item_id).delete
    # @order.items.delete_at(@order.items.index(@item.name) || @order.items.length)
    self.delete! if self.order_items.count == 0
	end

	def self.reorder(order,user)
		@new_order = user.orders.create is_placed?:true
    order.order_items.each do |item|
      new_item = item.clone
      new_item.order = @new_order
      new_item.save!
    end
  end

  def confirm
    self.update_attributes! is_placed?: true
  end



end
