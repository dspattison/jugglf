class Raid < ActiveRecord::Base
  attr_accessible :date, :date_string, :note, :thread, :attendance_output, :loot_output

  has_many :attendees, :dependent => :destroy
  has_many :loots, :order => "purchased_on ASC", :dependent => :destroy
  has_many :members, :through => :attendees, :order => "#{Member.table_name}.name ASC"

  validates_presence_of :date

  before_update :clear_attendees
  after_create [:parse_attendees, :parse_drops]
  after_update [:parse_attendees, :parse_drops]

  scope :latest, lambda { where("date >= ?", 2.months.ago).order('date DESC') }

  attr_writer :attendance_output
  attr_accessor :loot_output

  def attendance_output
    str = ''
    self.attendees.each { |att| str << "#{att.member.name},#{att.attendance}\n" }
    str.strip!
  end

  def date_string
    ( self.date.nil? ) ? Date.today.to_s : self.date.to_s(:db)
  end
  def date_string=(value)
    self.date = Time.parse(value)
  end

  def to_s
    "#{self.date}"
  end

  # Class Methods -------------------------------------------------------------
  def self.count_last_thirty_days
    Raid.count(:conditions => [ "date >= ?", 30.days.until(Date.today) ])
  end
  def self.count_last_ninety_days
    Raid.count(:conditions => [ "date >= ?", 90.days.until(Date.today) ])
  end

  # Instance Methods ----------------------------------------------------------
  def is_in_last_thirty_days?
    self.date >= 30.days.until(Date.today)
  end
  def is_in_last_ninety_days?
    self.date >= 90.days.until(Date.today)
  end

  private
    def clear_attendees
      return if @attendance_output.nil? or @attendance_output.empty?

      # OPTIMIZE: Generates a ton of queries:
      #   [ Old Attendees * 3 ] - Remove Attendee record; Update Member and Raid attendee_count caches
      #   [ New Attendees * 3 ] - Find member by name, insert attendee, update Member attendee_count cache
      #   [ New Attendees * 10 ] - Update Member cache
      self.attendees.delete_all

      # What we need to do is store our old attendees, parse our new attendees,
      # find out which of the old aren't in the new, and delete those
      # Then let the rescue block in parse_attendees handle updating attendance
      # Although that wouldn't really work since it always goes for the lower value,
      # so we couldn't give a member 'more' attendance for this raid. Might just have
      # to delete anything that changes at all.
    end

    def parse_attendees
      return if @attendance_output.nil? or @attendance_output.empty?

      attendees = AttendanceParser.parse_attendees(@attendance_output)
      return if attendees.nil? or attendees.size == 0

      attendees.each do |att|
        member = Member.find_or_initialize_by_name(att[:name])

        begin
          self.attendees.create(:member => member, :attendance => att[:attendance])
        rescue ActiveRecord::StatementInvalid => e
          # Probably a duplicate entry error caused by having the same member
          # twice or more in the output; find the member by name and then
          # see which attendance value is lower and use that
          existing = self.attendees.find_by_member_id(member.id)
          if not existing.nil? and att[:attendance] < existing.attendance
            existing.attendance = att[:attendance]
            existing.save
          end
        end
      end
    end

    def parse_drops
      return if @loot_output.nil? or @loot_output.empty?

      loots = AttendanceParser.parse_loots(@loot_output)
      return if loots.nil? or loots.size == 0

      loots.each do |attributes|
        self.loots.create(attributes.merge(:purchased_on => self.date))
      end
    end
end
