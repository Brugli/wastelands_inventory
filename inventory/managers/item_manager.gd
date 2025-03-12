extends Node

const ITEM_PATH = "res://inventory/items/data/items.json"

var items = {}

onready var placeholders = {
	GameEnums.EQUIPMENT_TYPE.BUMPER : preload("res://inventory/resources/placeholder_bumper.png"),
	GameEnums.EQUIPMENT_TYPE.CAB : preload("res://inventory/resources/placeholder_cab.png"),
	GameEnums.EQUIPMENT_TYPE.ENGINE : preload("res://inventory/resources/placeholder_engine.png"),
	GameEnums.EQUIPMENT_TYPE.EXHAUST : preload("res://inventory/resources/placeholder_exhaust.png"),
	GameEnums.EQUIPMENT_TYPE.FRONT_WHEELS : preload("res://inventory/resources/placeholder_wheel.png"),
	GameEnums.EQUIPMENT_TYPE.BACK_WHEELS : preload("res://inventory/resources/placeholder_wheel.png")
}

func _ready():
	var file = File.new()
	file.open(ITEM_PATH, File.READ)
	items = parse_json(file.get_as_text())
	file.close()

func get_item(id : String):
	return Item.new(id, items[id])

func get_placeholder(id):
	return placeholders[id]
