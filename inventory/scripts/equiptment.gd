extends Inventory

export(NodePath) onready var bumper = get_node(bumper) as InventorySlot
export(NodePath) onready var cab = get_node(cab) as InventorySlot
export(NodePath) onready var engine = get_node(engine) as InventorySlot
export(NodePath) onready var exhaust = get_node(exhaust) as InventorySlot
export(NodePath) onready var front_wheels = get_node(front_wheels) as InventorySlot
export(NodePath) onready var back_wheels = get_node(back_wheels) as InventorySlot

func _ready():
	slots.append(bumper)
	slots.append(cab)
	slots.append(engine)
	slots.append(exhaust)
	slots.append(front_wheels)
	slots.append(back_wheels)
	SignalManager.emit_signal("inventory_ready", self)

func set_inventory_size(value):
	size = value
