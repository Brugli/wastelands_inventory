extends NinePatchRect


export(NodePath) onready var inventory_container = get_node(inventory_container) as Control

var current_inventories : Array = []
	
func _ready():
	SignalManager.connect("inventory_opened", self, "_on_inventory_opened")
	
func close():
	for i in current_inventories:
		inventory_container.remove_child(i)
		
	current_inventories = []
	hide()

func _on_inventory_opened(inventory:Inventory):
	if current_inventories.has(inventory):
		return
		
	inventory_container.add_child(inventory)
	current_inventories.append(inventory)
	show()
