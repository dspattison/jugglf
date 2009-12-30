# == Schema Information
#
# Table name: live_loots
#
#  id          :integer(4)      not null, primary key
#  wow_id      :integer(4)
#  item_name   :string(255)
#  member_name :string(255)
#  loot_type   :string(255)
#

class LiveLoot < ActiveRecord::Base
  attr_accessible :wow_id, :item_name, :member_name, :loot_type
  validates_presence_of :item_name
  validates_inclusion_of :loot_type, :in => %w(bis rot sit bisrot), :allow_nil => true
  
  # Takes a block of text in a specific format and creates instances of +LiveLoot+ objects.
  #
  # For example, passing in the following text...
  #
  #   DE, Tsigo - [Snowserpent Mail Helm]|49952
  #   Duskshadow - [Crushing Coldwraith Belt]|49978
  #   Sebudai (sit) - Stygian Bladebreaker|47255
  #   Kazanir bis - [Death's Choice]|47303
  #
  # ...will return an array with the following *unsaved* objects
  #
  #   #<LiveLoot id: nil, wow_id: 49952, item_name: "Snowserpent Mail Helm", member_name: nil, loot_type: nil>
  #   #<LiveLoot id: nil, wow_id: 49952, item_name: "Snowserpent Mail Helm", member_name: "Tsigo", loot_type: nil>
  #   #<LiveLoot id: nil, wow_id: 49978, item_name: "Crushing Coldwraith Belt", member_name: "Duskshadow", loot_type: nil>
  #   #<LiveLoot id: nil, wow_id: 47255, item_name: "Stygian Bladebreaker", member_name: "Sebudai", loot_type: "sit">
  #   #<LiveLoot id: nil, wow_id: 47303, item_name: "Death's Choice", member_name: "Kazanir", loot_type: "bis">
  #
  # Note that both the parenthesis around loot types and the brackets around the item name are optional.
  def self.from_text(input)
    retval = []
    return retval unless input.present?
    
    input.split("\n").each do |line|
      line.strip!
      
      # Expects a member name with optional tell types, a space, a hyphen, a space, and then an item name
      # with or without brackets and an optional item ID, appended in the format "|12345"
      matches = line.match(/^([\w,\(\)\s]+) - ([^\|]+)(?:\|([0-9]+))?$/)
      if matches and matches.length >= 2
        # Handle multiple buyers on the same item
        buyers = matches[1].split(',')
        buyers.each do |buyer|
          buyer.strip!
          
          loot = LiveLoot.new
          loot.wow_id      = matches[3].to_i
          loot.item_name   = matches[2].gsub(/\[(.+)\]/, '\1').strip # Remove brackets
          loot.member_name = buyer.gsub(/^([^\s]+).*/, '\1') unless buyer == 'DE'
          loot.loot_type   = buyer.gsub(/^(\w+) \(?(bis|rot|bisrot|sit)\)?$/, '\2') if buyer.match(/\s\(?(bis|rot|bisrot|sit)\)?$/)
          
          retval << loot
        end
      end
    end
  
    retval
  end
end
