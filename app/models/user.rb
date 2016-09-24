class User
  include Mongoid::Document
  include Tokenable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :name, type: String
  field :email, type: String
  field :is_moo?, type: Boolean, default: false
  field :filters, type: Array, default: []

  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :encrypted_password

  has_many :orders
end
