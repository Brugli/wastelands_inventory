extends VehicleBody

export(NodePath) onready var pickup_area = get_node(pickup_area) as Area
export(NodePath) onready var pickup_labels = get_node(pickup_labels) as Control

var current_interactable

var max_rpm = 400
var max_torque = 150

func _ready():
	SignalManager.connect("update_mesh", self, "_update_mesh")
	SignalManager.connect("item_dropped", self, "_on_item_dropped")

func _physics_process(delta: float) -> void:

		
	steering = lerp(steering, Input.get_axis("steer_right", "steer_left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("reverse", "forward")
	var rpm = abs($BackLeft.get_rpm())
	$BackLeft.engine_force = acceleration * max_torque * (1-rpm/max_rpm)
	rpm = abs($BackRight.get_rpm())
	$BackRight.engine_force = acceleration * max_torque * (1-rpm/max_rpm)

func _process(_delta):
	if not current_interactable:
		var overlapping_area = pickup_area.get_overlapping_areas()
		
		if overlapping_area.size() > 0 and overlapping_area[0].has_method("interact"):
			current_interactable = overlapping_area[0]
			pickup_labels.display(current_interactable)

func _input(event):
	if event.is_action_pressed("interact") and current_interactable:
		current_interactable.interact()

func _on_pickup_area_exited(area):
	if current_interactable == area:
		pickup_labels.hide()
		current_interactable = null

func _update_mesh(type, new_item):
	#var child_node
	if type == GameEnums.EQUIPMENT_TYPE.CAB:
		if not new_item:
			get_child(4).get_child(0).queue_free()
			get_child(4).add_child(load("res://MeshInstance.tscn").instance())
		else:
			var id = new_item.id
			print("cab_updated")
			get_child(4).get_child(0).queue_free()
			get_child(4).add_child(load("res://" + id + ".tscn").instance())
	if type == GameEnums.EQUIPMENT_TYPE.FRONT_WHEELS:
		if not new_item:
			get_child(0).get_child(0).queue_free()
			get_child(1).get_child(0).queue_free()
			get_child(0).add_child(load("res://default_wheel.tscn").instance())
			get_child(1).add_child(load("res://default_wheel.tscn").instance())
		else:
			var id = new_item.id
			print("front wheels updated")
			get_child(0).get_child(0).queue_free()
			get_child(1).get_child(0).queue_free()
			get_child(0).add_child(load("res://" + id + ".tscn").instance())
			get_child(1).add_child(load("res://" + id + ".tscn").instance())
	if type == GameEnums.EQUIPMENT_TYPE.BACK_WHEELS:
		if not new_item:
			get_child(2).get_child(0).queue_free()
			get_child(3).get_child(0).queue_free()
			get_child(2).add_child(load("res://default_wheel.tscn").instance())
			get_child(3).add_child(load("res://default_wheel.tscn").instance())
		else:
			var id = new_item.id
			print("back wheels updated")
			get_child(2).get_child(0).queue_free()
			get_child(3).get_child(0).queue_free()
			get_child(2).add_child(load("res://" + id + ".tscn").instance())
			get_child(3).add_child(load("res://" + id + ".tscn").instance())

func _on_item_dropped(item):
	var world_item = load("res://inventory/items/scenes/world_item.tscn").instance()
	world_item.item = item
	get_parent().add_child(world_item)
	world_item.position = position
