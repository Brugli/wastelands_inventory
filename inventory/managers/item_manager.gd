extends Node

const ITEM_PATH = "res://inventory/items/data/items.json"
const AFFIXES_PATH = "res://inventory/items/data/affixes.json"

var items = {}
var affix_groups = {}

onready var placeholders = {
	GameEnums.EQUIPMENT_TYPE.BUMPER : preload("res://inventory/resources/placeholder_bumper.png"),
	GameEnums.EQUIPMENT_TYPE.CAB : preload("res://inventory/resources/placeholder_cab.png"),
	GameEnums.EQUIPMENT_TYPE.ENGINE : preload("res://inventory/resources/placeholder_engine.png"),
	GameEnums.EQUIPMENT_TYPE.EXHAUST : preload("res://inventory/resources/placeholder_exhaust.png"),
	GameEnums.EQUIPMENT_TYPE.FRONT_WHEELS : preload("res://inventory/resources/placeholder_wheel.png"),
	GameEnums.EQUIPMENT_TYPE.BACK_WHEELS : preload("res://inventory/resources/placeholder_wheel.png")
}

func _init():
	randomize()

func _ready():
	var file = File.new()
	
	#Items
	file.open(ITEM_PATH, File.READ)
	items = parse_json(file.get_as_text())
	file.close()
	
	#Affix_groups
	file.open(AFFIXES_PATH, File.READ)
	var data = parse_json(file.get_as_text())
	for id in data:
		affix_groups[id] = AffixGroup.new(id, data[id])
	file.close()

func get_item(id : String):
	return Item.new(id, items[id])

func get_placeholder(id):
	return placeholders[id]
	
func rng_gen_rarity(ilvl) -> Item:
	var valid_items_key = []
	for i in items:
		if items[i].has("type") and ilvl >= items[i].level and GameEnums.EQUIPMENT_TYPE[items[i].type]:
			valid_items_key.append(i)
	valid_items_key.shuffle()
	var item = get_item(valid_items_key[randi() % valid_items_key.size()])
	return gen_rarity(item, ilvl)
	
func gen_rarity(item, ilvl) -> Item:
	item.components.base_stats.scale = randf()
	
	var number_of_affixes = 0
	var rng = randf()
	
	if rng >= 0.99: #1%
		item.rarity = GameEnums.RARITY.UNIQUE
		return item
	elif rng >= 0.9: #9%
		item.rarity = GameEnums.RARITY.LEGENDARY
		number_of_affixes = 1
		#print(number_of_affixes)
	elif rng >= 0.6: #30%
		item.rarity = GameEnums.RARITY.RARE
		number_of_affixes = 1
		#print(number_of_affixes)
	else:
		return item
	print("hello")
	# Set the affixes
	var random_affix_group = get_random_affix_group( number_of_affixes, item.equipment_type, ilvl )
	var item_affix_list_data = []
	
	for affix_group in random_affix_group:
		var data = {
			"affix_group": affix_group.id,
			"affix": affix_group.get_random_affix( ilvl ),
			"scale": randf()
		}
		item_affix_list_data.append( data )
	
	item.components[ "affix_list" ] = ItemAffixList.new( item_affix_list_data, item.rarity )
	return item

	
	
func get_random_affix_group(number_of_affixes, item_type, ilvl) -> Array:
	var valid_prefix = get_valid_affixes_group(GameEnums.AFFIX_TYPE.PREFIX, item_type, ilvl)
	print(valid_prefix)
	valid_prefix.shuffle()
	
	var prefix_amount = 1
	
	#if number_of_affixes % 2 == 1:
	#	if randi() % 2 == 1:
	#		prefix_amount += 1
	
	valid_prefix.resize(prefix_amount)
	
	var valid_affixes = []
	valid_affixes.append_array(valid_prefix)
	return valid_affixes
	
func get_valid_affixes_group(affix_type, item_type, ilvl):
	var valid_affixes = []
	
	for id in affix_groups:
		if (affix_groups[id].type == affix_type
			and ilvl >= affix_groups[id].affixes.values()[0].min_level 
			and affix_groups[id].apply_to.has(item_type)):
				valid_affixes.append(affix_groups[id])
	return valid_affixes
