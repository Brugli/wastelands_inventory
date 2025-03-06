extends VehicleBody

export(NodePath) onready var pickup_area = get_node(pickup_area) as Area
export(NodePath) onready var pickup_labels = get_node(pickup_labels) as Control

var current_interactable

var max_rpm = 400
var max_torque = 150

func _ready():
	SignalManager.connect("update_mesh", self, "_update_mesh")

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
	var child_node
	if type == GameEnums.EQUPTMENT_TYPE.CAB:
		if not new_item:
			get_child(4).get_child(0).queue_free()
			child_node = load("res://MeshInstance.tscn").instance()
			get_child(4).add_child(child_node)
		else:
			var id = new_item.id
			print("cab_updated")
			get_child(4).get_child(0).queue_free()
			child_node = load("res://" + id + ".tscn").instance()
			get_child(4).add_child(child_node)

