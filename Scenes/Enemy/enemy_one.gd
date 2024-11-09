extends CharacterBody2D

@export var movement_speed = 80.0
@export var hp=6
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO
var experience = 1
@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")


var loot_drop = preload("res://Scenes/item scenes/pickup_plastic.tscn")

signal remove_from_array(object)

func _physics_process(delta):
	knockback =knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()

func death():
	emit_signal("remove_from_array", self)
	var new_loot = loot_drop.instantiate()
	new_loot.global_position = global_position
	new_loot.experience = experience
	loot_base.call_deferred("add_child",new_loot)
	queue_free()

func _on_hurtbox_hurt(damage,angle,knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp<0:
		death()
	
		
