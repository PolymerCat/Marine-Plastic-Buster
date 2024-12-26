extends Control

@onready var ui_click_sfx = $ui_click_sfx


func _on_play_pressed():
	ui_click_sfx.play(0.2)
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_control_pressed():
	ui_click_sfx.play(0.2)
	#await get_tree().create_timer(0.3).timeout
	#get_tree().change_scene_to_file("res://Scenes/menus/example_menu_controls.tscn")
	#pass


func _on_quit_pressed():
	ui_click_sfx.play(0.2)
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()
