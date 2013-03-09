class Video < ActiveRecord::Base
  attr_accessible :url, :user

  validates_presence_of :url

  belongs_to :user, primary_key: :user_id
end