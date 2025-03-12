class_name Affix extends Resource

var id : String
var affix_name : String
var min_level : int

func _init(affix_id, data):
	id = affix_id
	affix_name = data.affix_name
	min_level = data.min_level
