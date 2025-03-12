class_name EquiptmentSlot extends InventorySlot


export(NodePath) onready var placeholder = get_node(placeholder) as TextureRect

export(GameEnums.EQUIPMENT_TYPE) var type

func _ready():
	placeholder.texture = ItemManager.get_placeholder(type)

func try_put_item(new_item: Item) -> bool:
	return (new_item.equipment_type == type || new_item.secondary_type == type) and .try_put_item(new_item)
	
func put_item(new_item:Item) -> Item:
	if new_item:
		if new_item.equipment_type != type and new_item.secondary_type != type:
			return new_item
		placeholder.hide()
	else:
		placeholder.show()
	SignalManager.emit_signal("update_mesh", type, new_item)
	print("sending_signal")
	return .put_item(new_item)
