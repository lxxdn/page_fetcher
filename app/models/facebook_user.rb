class FacebookUser < ActiveRecord::Base
  attr_accessible :name, :image_url, :identity
  
  validates_uniqueness_of :identity
end
