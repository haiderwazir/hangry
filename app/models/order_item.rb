class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :price, type: Money
  field :flavor, type: String

  validates_presence_of :price

  belongs_to :order
  belongs_to :menu_item
end
