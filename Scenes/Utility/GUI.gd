extends CanvasLayer

# IGNORE THIS SCRIPT
# CURRENTLY THESE DO NOT WORK. IM STILL WORKING ON THEM
@onready var xp_bar = %xp_bar
@onready var label_level = %Label_Level
@onready var time_bar = $GUI/time_bar
@onready var time_label = $GUI/time_bar/time_label
@onready var loot_label = $GUI/Sprite2D/Label
@onready var player = get_tree().get_first_node_in_group("player")

#@onready var w_animation = $GUI/w_animation
#@onready var a_animation = $GUI/a_animation
#@onready var s_animation = $GUI/s_animation
#@onready var d_animation = $GUI/d_animation
@onready var bestiary_click_sfx = $bestiary_click_sfx
@onready var game_over_2 = $game_over2

func get_xp_bar():
	return xp_bar
func get_level_label():
	return label_level

signal open_bestiary()


func _on_texture_button_pressed():
	bestiary_click_sfx.play()
	print("Open Bestiary")
	open_bestiary.emit()


func _on_game_manager_game_end():
	game_over_2.play("game_over")

