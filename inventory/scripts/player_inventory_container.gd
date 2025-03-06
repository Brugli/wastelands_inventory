extends NinePatchRect

export(NodePath) onready var inventory = get_node(inventory) as Inventory
export(NodePath) onready var equiptment = get_node(equiptment) as Inventory

func _ready():
	var inventories = [inventory, equiptment]
	SignalManager.emit_signal("player_inventory_ready", inventories)


