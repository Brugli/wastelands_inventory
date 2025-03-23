class_name AffixItem extends Resource

var affix_group: AffixGroup
var affix : Affix
var scale: float

func _init(data):
	affix_group = ItemManager.affix_groups[data.affix_group]
	affix = affix_group.affixes[data.affix]
	scale = data.scale

func set_info(item_info, rarity):
	for stat_range in affix.stat_ranges:
		var display = ResourceManager.stat_info[stat_range.stat].display
		var value = stat_range.get_value(scale, stat_range.stat)
		var text = display % value
		item_info.add_line(ItemInfoLine.new(text, rarity))
