extends Control

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("Blur")
	print("resuming")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("Blur")
	print("pausing")
	
func testEsc():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		print("pause")
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		print("resume")
		resume()


func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menus/main_menu.tscn")

func _process(delta):
	testEsc()
