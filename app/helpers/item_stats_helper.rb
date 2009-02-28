module ItemStatsHelper
  def link_to_wowhead(item)
    if item.item_stat.nil?
      stat = ItemStat.lookup(item.name)
      item.update_attributes(:item_stat_id => stat.id) unless stat.nil?
    else
      stat = item.item_stat
    end
    
    "<a href='#{stat.wowhead_link}' class='#{stat.color}'>#{h(item.name)}</a>" unless stat.nil?
  end
  
  def link_to_item_with_stats(item)
    if item.item_stat.nil?
      stat = ItemStat.lookup(item.name)
      item.update_attributes(:item_stat_id => stat.id) unless stat.nil?
    else
      stat = item.item_stat
    end
    
    "<a href='#{item_path(item)}' rel='item=#{stat.item_id}' class='#{stat.color}'>#{h(item.name)}</a>" unless stat.nil?
  end
end