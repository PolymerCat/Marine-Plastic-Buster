extends Control
@onready var animation = $AnimationPlayer



func resume():
	get_tree().paused = false
	#$AnimationPlayer.play_backwards("Blur")
	print("resuming")

func _on_buy_player_speed_pressed():
	pass # Replace with function body.


func _on_buy_weapon_speed_pressed():
	pass # Replace with function body.


func _on_buy_weapon_damage_pressed():
	pass # Replace with function body.


func _on_buy_net_weapon_pressed():
	pass # Replace with function body.


func _on_done_pressed():
	animation.play("Hide")
	await get_tree().create_timer(0.5).timeout
	resume()
	done_buy.emit()


signal done_buy()


func _on_game_manager_round_end(game_state):
	animation.play("show")
	get_tree().paused = game_state
