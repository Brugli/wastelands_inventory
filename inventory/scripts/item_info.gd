class_name ItemInfo extends NinePatchRect

export(NodePath) onready var line_container = get_node(line_container) as Control  

var type_names = {
	GameEnums.EQUIPMENT_TYPE.BUMPER: "Bumper",
	GameEnums.EQUIPMENT_TYPE.CAB: "Cab",
	GameEnums.EQUIPMENT_TYPE.ENGINE: "Engine",
	GameEnums.EQUIPMENT_TYPE.EXHAUST: "Exhaust",
	GameEnums.EQUIPMENT_TYPE.FRONT_WHEELS: "Wheel",
	GameEnums.EQUIPMENT_TYPE.BACK_WHEELS: "Wheel"
}

func display(slot:InventorySlot):
	for c in line_container.get_children():
		line_container.remove_child(c)
		c.queue_free()
		
	rect_size.x = 0
	
	var line_name = ItemInfoLine.new(slot.item.get_name(), Color.black)
	line_container.add_child(line_name)
	var rarity_name = GameEnums.RARITY.keys()[slot.item.rarity].capitalize()
	var line_type = ItemRarityLine.new(rarity_name + " " + type_names[slot.item.equipment_type], slot.item.rarity)
	line_container.add_child(line_type)

	for c in slot.item.components.values():
		c.set_info(self)
		
	show()
	
	yield(get_tree(), "idle_frame")
	
	var max_width = 0
	var height = 0
	for c in line_container.get_children():
		height += c.rect_size.y + 4
		if c.rect_size.x > max_width:
			max_width = c.rect_size.x
	rect_size = Vector2(max_width + 8, height + 8)
	var info_offset = Vector2(max_width + 8, 0)
	
	rect_global_position = slot.rect_global_position - info_offset

func add_line(line):
	line_container.add_child(line)

