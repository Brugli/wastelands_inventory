class_name ItemRarityLine extends Label


func _init(value, color):
	text = value
	align = Label.ALIGN_LEFT
	valign = Label.VALIGN_CENTER
	#set("custom_fonts/font", ResourceManager.fonts[8])
	set("custom_colors/font_color", ResourceManager.colors[color])
