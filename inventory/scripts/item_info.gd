extends NinePatchRect

export(NodePath) onready var item_name = get_node(item_name) as Label

var info_offset = Vector2((-rect_size.x) - 18, (-rect_size.y/2))  

func display(slot:InventorySlot):
	var slot_center = Vector2(slot.rect_global_position.x + 18, slot.rect_global_position.y + 18)
	rect_global_position = slot_center + info_offset
	item_name.text = slot.item.item_name
	show()

