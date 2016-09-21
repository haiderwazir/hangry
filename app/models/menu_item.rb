class MenuItem
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  
  field :name, type: String
  field :description, type: String
  field :price, type: Money
  field :filters, type: Array, default: []
  field :flavors, type: Array, default: []

  has_mongoid_attached_file :picture
  validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :order_items, :dependent => :destroy


end
