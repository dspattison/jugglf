class Loot < ActiveRecord::Base
  # Relationships -------------------------------------------------------------
  belongs_to :member, :counter_cache => true
  alias_method :buyer, :member
  belongs_to :raid, :counter_cache => true
  belongs_to :item, :counter_cache => true
  
  # Attributes ----------------------------------------------------------------
  attr_accessor :update_cache
  
  attr_accessible(:item, :item_name, :price, :purchased_on, :best_in_slot, 
    :situational, :rot, :member, :member_id, :member_name, :raid_id, :update_cache)
  
  def item_name
    self.item.name unless self.item_id.nil?
  end
  def item_name=(value)
    self.item = Item.find_by_name_or_wow_id(value)
  end
  
  def member_name
    self.member.name unless self.member_id.nil?
  end
  def member_name=(value)
    self.member = Member.find_by_name(value)
  end
  
  # Validations ---------------------------------------------------------------
  validates_numericality_of :price, :allow_nil => true
  
  # Callbacks -----------------------------------------------------------------
  before_save [:set_purchased_on]
  after_save [:update_buyer_cache]
  
  # Class Methods -------------------------------------------------------------
  
  # Instance Methods ----------------------------------------------------------
  def affects_loot_factor?
    self.purchased_on >= 52.days.until(Date.today)
  end
  
  def adjusted_price
    ( self.rot? ) ? 0.50 : self.price
  end
  
  # Returns the value of the given purchase type (Normal, Rot, Situational, Best In Slot)
  def has_purchase_type?(purchase_type)
    purchase_type = purchase_type.to_s.gsub(' ', '_').strip
    
    if purchase_type.to_s.match(/^normal/i)
      return (not self.best_in_slot? and not self.situational?)
    else
      return eval("self.#{purchase_type}") if self.respond_to?(purchase_type)
    end
  end
  
  private
    def set_purchased_on
      if self.purchased_on.nil? and not self.raid_id.nil?
        self.purchased_on = self.raid.date
      end
    end
    
    def update_buyer_cache
      self.member.update_cache unless @update_cache == false or self.member_id.nil?
    end
end
