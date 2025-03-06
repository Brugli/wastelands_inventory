extends VBoxContainer

export(NodePath) onready var action_label = get_node(action_label) as Label
export(NodePath) onready var object_name_label = get_node(object_name_label) as Label

func display(interactable):
	action_label.text = "Press E to " + interactable.action
	object_name_label.text = interactable.object_name
	show()
