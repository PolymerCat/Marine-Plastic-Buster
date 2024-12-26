extends Control
@onready var animation = $AnimationPlayer
@onready var attack = get_tree().get_first_node_in_group("attack_manager")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_manager = get_tree().get_first_node_in_group("loot_manager")
@onready var gui = get_tree().get_first_node_in_group("gui")
@onready var wd_value = $ColorRect/WeaponDamage/WDValue
@onready var ps_value = $ColorRect/PlayerSpeed/PSValue
@onready var ws_value = $ColorRect/WeaponSpeed/WSValue

@onready var player_speed_price = $ColorRect/PlayerSpeed/player_speed_price
@onready var weapon_speed_price = $ColorRect/WeaponSpeed/weapon_speed_price
@onready var weapon_damage_price = $ColorRect/WeaponDamage/weapon_damage_price
@onready var ui_click_sfx = $ui_click_sfx
@onready var not_enuff = $not_enuff



var loot = 0
var weapon_up_price = 15
var weapon_speed_up_price = 15
var player_speed_up_price = 20

func _ready():
	wd_value.text = str(attack.stick_level)
	ps_value.text = str(player.SPEED)
	ws_value.text = str(attack.stick_attack_speed)
	player_speed_price.text = "Price: " + str(player_speed_up_price)
	weapon_speed_price.text = "Price: " + str(weapon_speed_up_price)
	weapon_damage_price.text = "Price: " + str(weapon_up_price)
	loot = loot_manager.current_loot

func resume():
	get_tree().paused = false
	#$AnimationPlayer.play_backwards("Blur")
	print("resuming")

func _on_buy_player_speed_pressed():
	ui_click_sfx.play(0.2)
	if loot>=player_speed_up_price:
		player.SPEED += 15
		ps_value.text = str(player.SPEED)
		loot_manager.current_loot -= player_speed_up_price
		player_speed_up_price += 30
		animation.play("Hide")
		await get_tree().create_timer(0.5).timeout
		resume()
		done_buy.emit()
	else:
		not_enough()


func _on_buy_weapon_speed_pressed():
	ui_click_sfx.play(0.2)
	if loot>=weapon_speed_up_price:
		if(attack.stick_attack_speed >0.3):
			attack.stick_attack_speed -= 0.3
			ws_value.text = str(attack.stick_attack_speed)
			loot_manager.current_loot -= weapon_speed_up_price
			weapon_speed_up_price += 30
			animation.play("Hide")
			await get_tree().create_timer(0.5).timeout
			resume()
			done_buy.emit()
	elif attack.stick_attack_speed <=0.3:
		print("Max level achieved")
	else:
		not_enough()


func _on_buy_weapon_damage_pressed():
	ui_click_sfx.play(0.2)
	if loot >= weapon_up_price:
		
		attack.upgrade_stick_level()
		wd_value.text = str(attack.stick_level)
		loot_manager.current_loot -= weapon_up_price
		weapon_up_price += 30
		animation.play("Hide")
		await get_tree().create_timer(0.5).timeout
		resume()
		done_buy.emit()
	else:
		not_enough()


func _on_buy_net_weapon_pressed():
	pass # Replace with function body.


func _on_done_pressed():
	ui_click_sfx.play(0.2)
	animation.play("Hide")
	await get_tree().create_timer(0.5).timeout
	resume()
	done_buy.emit()


signal done_buy()
signal minus_loot(price)

func _on_game_manager_round_end(game_state):
	loot = loot_manager.current_loot
	player_speed_price.text = "Price: " + str(player_speed_up_price)
	weapon_speed_price.text = "Price: " + str(weapon_speed_up_price)
	weapon_damage_price.text = "Price: " + str(weapon_up_price)
	animation.play("show")
	get_tree().paused = game_state
	
func not_enough():
	print("Not enough plastics!")
	not_enuff.play("not_enuff")

