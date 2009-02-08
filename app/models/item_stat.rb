# == Schema Information
# Schema version: 20090208213027
#
# Table name: item_stats
#
#  id         :integer(4)      not null, primary key
#  item       :string(255)
#  locale     :string(10)      default("en")
#  color      :string(15)
#  icon       :string(255)
#  level      :integer(8)      default(0)
#  slot       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ItemStat < ActiveRecord::Base
end
