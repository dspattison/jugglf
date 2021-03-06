module MembersHelper
  def member_with_rank_formatting(member)
    return if member.nil?
    return member.name if member.rank_id.nil?

    member.rank.format(member.name)
  end

  def link_to_member(member)
    link_to h(member.name), member_path(member), :class => member.wow_class unless member.nil?
  end

  def link_to_armory(member)
    link_to h(member.name), "http://www.wowarmory.com/character-sheet.xml?r=Mal%27Ganis&n=#{member.name}", :class => member.wow_class unless member.nil?
  end

  def member_raid_attendance(raid, member)
    return if raid.nil? or member.nil?

    raid.attendees.each do |a|
      return raid_attendance_colored(a.attendance) if a.member_id == member.id
    end

    return raid_attendance_colored(0)
  end

  # OPTIMIZE: Generates a lot of queries, although most of them are from cache
  def member_completed_achievement(ach, member)
    return if ach.nil? or member.nil?

    ach.completed_achievements.each do |c|
      return c.completed_on if c.member_id == member.id
    end

    return ''
  end

  def member_attendance_colored(value)
    return if value.nil?

    if value.class == Float
      value = (value * 100).floor
    end

    if value >= 0 and value <= 34
      class_str = 'negative'
    elsif value >= 35 and value <= 66
      class_str = 'neutral'
    elsif value >= 67 and value <= 100
      class_str = 'positive'
    else
      class_str = 'neutral'
    end

    content_tag(:span, "#{value}%", :class => class_str)
  end

  def raid_attendance_colored(value)
    return if value.nil?

    if value.class == Float
      value = (value * 100).floor
    end

    value = value.to_i

    if value == 100
      class_str = 'positive'
    elsif value == 0
      class_str = 'negative'
    else
      class_str = 'neutral'
    end

    content_tag(:span, "#{value}%", :class => class_str)
  end

  def loot_factor(value)
    number_with_precision(value, :precision => 2)
  end

  def warn_if_recently_looted(wishlist, loots)
    return unless loots.present?

    loots.each do |loot|
      if wishlist.member_id == loot.member_id and loot.item_id == wishlist.item_id and loot.has_purchase_type?(wishlist.priority)
        return image_tag('error.png', :class => 'help', :title => 'This item may have been recently looted.')
      end
    end

    return nil
  end
end
