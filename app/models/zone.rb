# == Schema Information
#
# Table name: zones
#
#  id       :integer(4)      not null, primary key
#  name     :string(255)     not null
#  position :integer(4)      default(0)
#

class Zone < ActiveRecord::Base
  has_many :loot_tables, :as => :object, :dependent => :destroy
  
  validates_presence_of :name
end
