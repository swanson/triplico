class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation
  has_secure_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :videos

  has_one :buddy_one, foreign_key: :buddy_one_id, class_name: "User"
  has_one :buddy_two, foreign_key: :buddy_two_id, class_name: "User"
end