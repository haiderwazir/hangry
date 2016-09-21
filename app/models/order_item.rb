class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :price, type: Money
  field :size, type: String
  field :flavor, type: String

  belongs_to :order
  belongs_to :menu_item
end
