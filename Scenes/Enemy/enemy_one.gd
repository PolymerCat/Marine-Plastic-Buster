extends CharacterBody2D

@export var movement_speed = 80.0
@export var hp=6
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO
var experience = 1
@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var animator = $AnimatedSprite2D
@onready var sfx = $AudioStreamPlayer2D
@onready var hit_flash_player = $hit_flash_player


var loot_drop = preload("res://Scenes/item scenes/pickup_plastic.tscn")

signal remove_from_array(object)

func _ready():
	hit_flash_player.play("hit_flash")

func _physics_process(delta):
	knockback =knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()

func death():
	emit_signal("remove_from_array", self)
	#velocity = Vector2.ZERO
	animator.play("die")
	sfx.play()
	await get_tree().create_timer(0.5).timeout
	var new_loot = loot_drop.instantiate()
	new_loot.global_position = global_position
	new_loot.experience = experience
	loot_base.call_deferred("add_child",new_loot)
	queue_free()



func _on_hurtbox_hurt(damage,angle,knockback_amount):
	hit_flash_player.play("hit_flash")
	hp -= damage
	knockback = angle * knockback_amount
	if hp<0:
		death()
	
		
