extends Control



func _on_play_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_control_pressed():
	#await get_tree().create_timer(0.3).timeout
	#get_tree().change_scene_to_file("res://Scenes/menus/example_menu_controls.tscn")
	pass


func _on_quit_pressed():
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()
