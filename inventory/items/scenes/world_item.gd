extends Area

export(NodePath) onready var outline = get_node(outline) as MeshInstance

export(String) var item_id

var item : Item
var action = "pickup"
var object_name = ""

func _ready():
	if not item:
		item = ItemManager.get_item(item_id)
		
	var outline_material = outline.get_surface_material(0)
	outline_material.emission = item.rarity
	object_name = item.item_name
	
	
func interact():
	SignalManager.emit_signal("item_picked", item, self)
	#queue_free()
func item_picked():
	queue_free()
