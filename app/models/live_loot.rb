class LiveLoot < ActiveRecord::Base
  attr_accessible :wow_id, :item_id, :member_id, :member_name, :loot_type

  belongs_to :item, :autosave => true, :readonly => true
  belongs_to :member, :readonly => true
  belongs_to :live_raid, :counter_cache => true

  validates_inclusion_of :loot_type, :in => %w(bis rot sit bisrot), :allow_nil => true, :message => "must be bis, rot, sit or bisrot"

  # Attempts to associate with an +Item+ given its +id+
  def wow_id=(value)
    self.item = Item.find_or_initialize_by_id(value)
  end

  # Returns the +id+ attribute of the associated +Item+, if present.
  def wow_id
    self.item_id unless self.item_id.nil?
  end

  # Attempts to associate with a +Member+ given its +name+
  def member_name=(value)
    self.member = Member.find_or_initialize_by_name(value)
  end

  # Returns the +name+ attribute of the associated +Member+, if present.
  def member_name
    self.member.name unless self.member_id.nil?
  end

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
  #   #<LiveLoot id: nil, item_id: 49952, item_name: "Snowserpent Mail Helm",    member_name: nil,          loot_type: nil>
  #   #<LiveLoot id: nil, item_id: 49952, item_name: "Snowserpent Mail Helm",    member_name: "Tsigo",      loot_type: nil>
  #   #<LiveLoot id: nil, item_id: 49978, item_name: "Crushing Coldwraith Belt", member_name: "Duskshadow", loot_type: nil>
  #   #<LiveLoot id: nil, item_id: 47255, item_name: "Stygian Bladebreaker",     member_name: "Sebudai",    loot_type: "sit">
  #   #<LiveLoot id: nil, item_id: 47303, item_name: "Death's Choice",           member_name: "Kazanir",    loot_type: "bis">
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

          live_loot = self.new
          live_loot.wow_id      = matches[3].to_i
          live_loot.member_name = buyer.gsub(/^([^\s]+).*/, '\1') unless buyer == 'DE'
          live_loot.loot_type   = buyer.gsub(/^(\w+)\s\(?([a-zA-Z\s]+)\)?$/, '\2').downcase if buyer.match(/\s\(?([a-zA-Z\s]+)\)?$/)

          retval << live_loot
        end
      else
        raise "Invalid loot string format: \"#{line}\""
      end
    end

    retval
  end

  # Dummy method for Formtastic
  attr_accessor :input_text # :nodoc:

  protected

  validate :ensure_member_exists, :on => :create

  def ensure_member_exists
    # Ensures that, when given a member record, it wasn't newly-created
    # We don't want to accidentally typo a member's name and have loot falsely get marked as DE'd.
    if self.member.present? and self.member.new_record?
      self.errors.add(:member, "attempted to assign loot to a member who did not yet exist: #{self.member.name}")
    end
    false
  end
end
