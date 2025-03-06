extends Button

export(int) var size
export(String) var inventory_name
export(Array, String) var items

var inventory:Inventory

func _init():
	inventory = preload("res://inventory/scenes/inventory.tscn").instance()
	
func _ready():
	inventory.size = size
	inventory.inventory_name = inventory_name

	for i in items:
		inventory.add_item(ItemManager.get_item(i))



func _on_Button_pressed():
	SignalManager.emit_signal("inventory_opened", inventory)
