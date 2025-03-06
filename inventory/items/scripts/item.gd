class_name Item extends TextureRect

var id
var item_name
var equiptment_type = GameEnums.EQUPTMENT_TYPE
var secondary_type = GameEnums.EQUPTMENT_TYPE
var level = 1
var components = {}

		
func _init(item_id, data):
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	id = item_id
	item_name = data.name
	level = data.level
	texture = load("res://inventory/items/resources/"+id+".png")
	
	if data.has("equiptment_type"):
		equiptment_type = GameEnums.EQUPTMENT_TYPE[data.equiptment_type]
		
	if data.has("secondary_type"):
		secondary_type = GameEnums.EQUPTMENT_TYPE[data.secondary_type]

func _ready():
	pass
