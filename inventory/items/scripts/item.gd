class_name Item extends TextureRect

var id
var item_name
var rarity = GameEnums.RARITY.SCRAP
var equipment_type = GameEnums.EQUIPMENT_TYPE
var secondary_type = GameEnums.EQUIPMENT_TYPE
var level = 1
var components = {}

		
func _init(item_id, data):
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	id = item_id
	item_name = data.name
	level = data.level
	texture = load("res://inventory/items/resources/"+id+".png")
	
	if data.has("rarity"): 
		rarity = GameEnums.RARITY[data.rarity]
		
	if data.has("equipment_type"):
		equipment_type = GameEnums.EQUIPMENT_TYPE[data.equipment_type]
		
	if data.has("secondary_type"):
		secondary_type = GameEnums.EQUIPMENT_TYPE[data.secondary_type]
		
	if data.has("base_stats"):
		components["base_stats"] = BaseStat.new(data.base_stats)

func get_name():
	if components.has( "affix_list" ) and rarity == GameEnums.RARITY.RARE:
		var prefix = ""
		
		for affix_item in components.affix_list.affixes:
			if affix_item.affix_group.type == GameEnums.AFFIX_TYPE.PREFIX:
				prefix = affix_item.affix.affix_name
		return ( "%s %s" % [ prefix, item_name] ).strip_edges()
	return item_name
	
