class MenuItem
	require 'CSV'
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :description, type: String
  field :pictureUrl, type: String
  field :price, type: Money
  field :filters, type: Array, default: []
  field :flavors, type: Array, default: []

  
  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :pictureUrl

  has_many :order_items, :dependent => :destroy

  def self.import_items(file)
    CSV.foreach(file,{:headers=>:first_row}) do |row|
      arr = [row[4], row[5], row[6], row[7], row[8]] 
      self.create! name: row[0], description: row[1], price: row[2], picture: row[3], flavors: arr
    end
  end

  def self.get_today
    menu_items= Array.new
    MenuItem.each do |item|
      menu_items << {name: item.name, times_ordered: item.order_items.where(created_at: (Time.now - 24.hours)..Time.now).count}
    end
    menu_items.to_json
  end
end
