extends Node2D

# Weapons
var stick = preload("res://Scenes/Attack/Stick.tscn")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var stick_timer = $StickTimer
@onready var stick_attack_timer = $StickAttackTimer
@onready var marker = $Marker2D


var stick_ammo = 0
var stick_base_ammo = 1
var stick_attack_speed = 1.5
var stick_level = 1

# Enemy
var enemy_close = []

func _ready():
	attack()


func attack():
	if stick_level > 0 :
		stick_timer.wait_time = stick_attack_speed
		if stick_timer.is_stopped():
			stick_timer.start()



func _on_stick_timer_timeout():
	stick_ammo += stick_base_ammo
	stick_attack_timer.start()


func _on_stick_attack_timer_timeout():
	if stick_ammo > 0:
		var stick_instance = stick.instantiate()
		stick_instance.position = marker.global_position
		stick_instance.target = get_random_target()
		stick_instance.level = stick_level
		add_child(stick_instance)
		stick_ammo -= 1
		if stick_ammo > 0:
			stick_attack_timer.start()
		else:
			stick_attack_timer.stop()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_enemy_detection_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
