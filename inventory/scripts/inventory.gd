class_name Inventory extends TextureRect

var inventory_slot_resource = preload("res://inventory/scenes/inventory_slot.tscn")

export(String) var inventory_name
export(int) var size = 0 setget set_container_size
#var open_slots

export(NodePath) onready var title = get_node(title) as Label
export(NodePath) onready var slot_container = get_node(slot_container) as Control

var slots : Array = []

func _ready():
	for s in slots:
		slot_container.add_child(s)
	
	title.text = "+ " + inventory_name + " +"
	SignalManager.emit_signal("inventory_ready", self)
	
func set_container_size(value):
	size = value
	
	for s in size:
		var new_slot = inventory_slot_resource.instance()
		slots.append(new_slot)

func add_item(item):
	for s in slots:
		if s.try_put_item(item):
			item = s.put_item(item)
			if not item:
				return null
	return item
