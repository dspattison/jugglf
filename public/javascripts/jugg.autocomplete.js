if (typeof JuggLF === "undefined") {
  var JuggLF = {};
}

(function($)
{
    /**
     * Adds jQuery Autocomplete for use on an 'Item Name' field
     *
     * Search results have an item icon, a colorzed item name and include the
     * slot and whether or not the item is Heroic.
     *
     * Example:
     *  $('#item_name').autocomplete_items();
     */
    $.fn.autocomplete_items = function(options)
    {
        var settings = jQuery.extend(options, {
          context: 'items'
        });

        return this.each(function()
        {
            $(this).autocomplete('/search.json', {
                minChars: 2,
                extraParams: settings,
                dataType: 'json',
                scrollHeight: 260,
                parse: function(data) {
                    var array = [];
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].item) {
                            var icon = ( data[i].item.icon ) ? data[i].item.icon.toLowerCase() : 'inv_misc_questionmark';
                            var slot = ( data[i].item.slot === null ) ? 'Token' : data[i].item.slot;
                            var heroic = ( data[i].item.heroic ) ? ' (Heroic)' : '';
                            var formatted = "<img src='http://static.wowhead.com/images/wow/icons/medium/" + icon + ".jpg'/>" +
                              "<span class='" + data[i].item.color + "'>" + data[i].item.name + "</span>" +
                              "<br/>" + data[i].item.level + " " + slot + heroic;

                            array[array.length] = {
                                data: data[i],
                                value: formatted,
                                result: this.formatResult(data[i].item)
                            };
                        }
                    }
                    return array;
                },
                formatResult: function(item) {
                    return item.name;
                },
                formatItem: function(row, i, max, value) {
                    return value;
                }
            });

            // On selected result, set the value of the item id to the item_id field
            $(this).result(function(event, data, formatted) {
              var id = $(this).attr('id').replace(/item_name/, 'item_id');
              $('#' + id).val(data.item.id);
            });
        });
    };

    /**
     * Adds jQuery Autocomplete for use on a 'Member Name' field
     *
     * Example:
     *  $('#member_name').autocomplete_members();
     */
    $.fn.autocomplete_members = function(options)
    {
        var settings = jQuery.extend(options, {
          context: 'members'
        });

        return this.each(function()
        {
            $(this).autocomplete('/search.json', {
                minChars: 1,
                extraParams: settings,
                dataType: 'json',
                parse: function(data) {
                    var array = [];
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].member) {
                            array[array.length] = {
                                data: data[i],
                                value: data[i].member.name,
                                result: data[i].member.name
                            };
                        }
                    }
                    return array;
                },
                formatItem: function(row, i, max, value) {
                    return value;
                }
            });
        });
    };
})(jQuery);
