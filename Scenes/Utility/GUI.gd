extends CanvasLayer

# IGNORE THIS SCRIPT
# CURRENTLY THESE DO NOT WORK. IM STILL WORKING ON THEM
@onready var xp_bar = %xp_bar
@onready var label_level = %Label_Level
@onready var time_bar = $GUI/time_bar
@onready var time_label = $GUI/time_bar/time_label
@onready var loot_label = $GUI/Sprite2D/Label

func get_xp_bar():
	return xp_bar
func get_level_label():
	return label_level
