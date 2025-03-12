extends NinePatchRect

export(NodePath) onready var inventory = get_node(inventory) as Inventory
export(NodePath) onready var equipment = get_node(equipment) as Inventory

func _ready():
	var inventories = [inventory, equipment]
	SignalManager.emit_signal("player_inventory_ready", inventories)


