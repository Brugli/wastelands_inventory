class_name AffixGroup extends Resource

var id : String
var type #GameEnums.AFFIX_TYPE
var affixes = {}
var apply_to = [] #GameEnums.EQUIPMENT_TYPE


func _init(group_id, data):
	id = group_id
	type = GameEnums.AFFIX_TYPE[data.type]
	
	for item_type in data.apply_to:
		apply_to.append(GameEnums.EQUIPMENT_TYPE[item_type])
	
	for affix_id in data.affixes:
		affixes[affix_id] = Affix.new(affix_id, data.affixes[affix_id])

func get_random_affix(ilevel):
	var valid_affixes = []
	for a in affixes:
		print(a)
		if ilevel >= affixes[a].min_level:
			valid_affixes.append(affixes[a])
			
	valid_affixes.shuffle()
	return valid_affixes[0].id
