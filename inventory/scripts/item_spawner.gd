extends Button

export( Array, String ) var items
var player_inventory 

func _ready():
	SignalManager.connect("player_inventory_ready", self, "set_items")
	

func _on_Button_pressed():
	#print(player_inventory)
	#for i in items:
	var item = ItemManager.get_item(items[randi() % items.size()])
	ItemManager.gen_rarity( item, 100 )
	player_inventory.add_item(item)

func set_items(inventories):
	player_inventory = inventories[0]
