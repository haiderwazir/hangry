class MenuItem
	require 'CSV'
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
  
  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :picture

  has_many :order_items, :dependent => :destroy

  def self.import_items(file)
  	CSV.foreach("file.csv") do |row|
  		arr = [row[4], row[5], row[6], row[7], row[8]] 
  		self.create! name: row[0], description: row[1], price: row[2], picture: row[3], flavors: arr
  	end
  end

end
