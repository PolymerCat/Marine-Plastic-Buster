extends Control
@onready var animation = $AnimationPlayer
@onready var attack = get_tree().get_first_node_in_group("attack_manager")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var wd_value = $ColorRect/WeaponDamage/WDValue
@onready var ps_value = $ColorRect/PlayerSpeed/PSValue
@onready var ws_value = $ColorRect/WeaponSpeed/WSValue

func _ready():
	wd_value.text = str(attack.stick_level)
	ps_value.text = str(player.SPEED)
	ws_value.text = str(attack.stick_attack_speed)

func resume():
	get_tree().paused = false
	#$AnimationPlayer.play_backwards("Blur")
	print("resuming")

func _on_buy_player_speed_pressed():
	player.SPEED += 15
	ps_value.text = str(player.SPEED)
	animation.play("Hide")
	await get_tree().create_timer(0.5).timeout
	resume()
	done_buy.emit()


func _on_buy_weapon_speed_pressed():
	if(attack.stick_attack_speed >0.3):
		attack.stick_attack_speed -= 0.3
		ws_value.text = str(attack.stick_attack_speed)
		animation.play("Hide")
		await get_tree().create_timer(0.5).timeout
		resume()
		done_buy.emit()


func _on_buy_weapon_damage_pressed():
	attack.upgrade_stick_level()
	wd_value.text = str(attack.stick_level)
	animation.play("Hide")
	await get_tree().create_timer(0.5).timeout
	resume()
	done_buy.emit()


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
