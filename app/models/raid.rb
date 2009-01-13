# == Schema Information
# Schema version: 20090113041939
#
# Table name: raids
#
#  id              :integer(4)      not null, primary key
#  date            :date
#  note            :string(255)
#  thread          :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#  items_count     :integer(4)      default(0)
#  attendees_count :integer(4)      default(0)
#

class Raid < ActiveRecord::Base
  # Relationships -------------------------------------------------------------
  has_many :attendees
  has_many :items, :order => "items.name ASC"
  has_many :members, :through => :attendees, :order => "name ASC"
  
  # Validations ---------------------------------------------------------------
  
  # Callbacks -----------------------------------------------------------------
  after_save :update_attendee_cache
  
  # Static Methods ------------------------------------------------------------
  def self.count_last_thirty_days
    Raid.count(:conditions => [ "date >= ?", 30.days.ago ])
  end
  def self.count_last_ninety_days
    Raid.count(:conditions => [ "date >= ?", 90.days.ago ])
  end
  
  # Methods -------------------------------------------------------------------
  def is_in_last_thirty_days?
    self.date >= 30.days.ago.to_datetime
  end
  def is_in_last_ninety_days?
    self.date >= 90.days.ago.to_datetime
  end
  
  def attendance_output
    require 'csv'
    out = ""
    
    CSV::Writer.generate(out) do |csv|
      self.attendees.each do |a|
        csv << [ a.member.name, a.attendance ]
      end
    end
    
    out
  end
  def attendance_output=(value)
    require 'csv'
    lines = CSV.parse(value) do |line|
      m = Member.find_or_initialize_by_name(line[0])
      m.uncached_updates += 1
      m.save
      
      self.attendees << Attendee.create(:member => m, :attendance => line[1])
    end
  end
  
  def loot_output
  end
  def loot_output=(value)
    lines = value.split("\n")
    lines.each do |line|
      items = Item.from_attendance_output(line)
      
      items.each do |item|
        item.save!
        
        self.items << item
      end
    end
  end
  
  private
    def update_attendee_cache
      self.attendees.each do |a|
        a.member.force_recache!
      end
    end
end
