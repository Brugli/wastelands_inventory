class_name Resource_Manager extends Node

const STAT_PATH = "res://inventory/items/data/stats.json"

var stat_info = {}

onready var colors = {
	GameEnums.RARITY.SCRAP: Color("c0c0c0"),
	GameEnums.RARITY.RARE: Color("008eff"),
	GameEnums.RARITY.LEGENDARY: Color("a80031"),
	GameEnums.RARITY.UNIQUE: Color("ffc400"),
}

func _ready():
	var file = File.new()
	#Stats
	file.open(STAT_PATH, File.READ)
	var data = parse_json(file.get_as_text())
	
	for stat in data:
		stat_info[GameEnums.STAT[stat]] = data[stat]
		
	file.close()
