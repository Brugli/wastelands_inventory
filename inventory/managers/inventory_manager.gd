extends Node

export(NodePath) onready var item_in_hand_node = get_node(item_in_hand_node) as Control
export(NodePath) onready var item_void = get_node(item_void) as Control
export(NodePath) onready var item_info = get_node(item_info) as Control

var inventories : Array = []
var player_inventories : Array = []
var item_in_hand : Item
var item_offset = Vector2.ZERO

func _ready():
	SignalManager.connect("item_picked", self, "_on_item_picked")
	SignalManager.connect("player_inventory_ready", self, "_on_player_inventory_ready")
	SignalManager.connect("inventory_ready", self, "_on_inventory_ready")
	item_void.connect("gui_input", self, "_on_void_gui_input")
	
func _on_inventory_ready(inventory):
	inventories.append(inventory)
	
	for slot in inventory.slots:
		slot.connect("mouse_entered", self, "_on_mouse_entered_slot", [slot])
		slot.connect("mouse_exited", self, "_on_mouse_exited_slot")
		slot.connect("gui_input", self, "_on_gui_input_slot", [slot])

func _input(event:InputEvent):
	if event is InputEventMouseMotion and item_in_hand:
		item_in_hand.rect_position = event.position - item_offset

func _on_mouse_entered_slot(slot):
	if slot.item:
		item_info.display(slot)
	
func _on_mouse_exited_slot():
	item_info.hide()
	
func _on_gui_input_slot(event:InputEvent, slot:InventorySlot):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var had_empty_hand = item_in_hand == null
		
		if item_in_hand:
			item_in_hand_node.remove_child(item_in_hand)
			
		item_in_hand = slot.put_item(item_in_hand)
		
		if item_in_hand:
			if had_empty_hand:
				item_offset = event.global_position - slot.rect_global_position
			item_in_hand_node.add_child(item_in_hand)
			
		set_hand_position(event.global_position)
		
func set_hand_position(pos):
	set_item_void_filter()
	if item_in_hand:
		item_in_hand.rect_position = (pos - item_offset)
	
func _on_item_picked(item, sender):
	for i in player_inventories:
		item = i.add_item(item)
		
		if not item:
			sender.item_picked()
			return
		
func _on_player_inventory_ready(inv):
	player_inventories = inv

func set_item_void_filter():
	item_void.mouse_filter = Control.MOUSE_FILTER_STOP if item_in_hand else Control.MOUSE_FILTER_IGNORE
	
func _on_void_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		SignalManager.emit_signal("item_dropped", item_in_hand)
		item_in_hand_node.remove_child(item_in_hand)
		item_in_hand = null
		set_item_void_filter()
