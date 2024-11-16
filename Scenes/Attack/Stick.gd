extends Area2D

@export var level = 1
@export var hp = 1
@export var speed = 100
@export var damage = 5
@export var knockback_amount = 100
@export var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO
@onready var hit_sfx = $hit_sfx

@onready var player = get_tree().get_first_node_in_group("player")
signal remove_from_array(object)

func _ready():
	# Sets the target shoot towards.
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp=1
			speed=100
			damage=5
			knockback_amount=100
			attack_size=1.0
	
	# Adjusts the size of stick attack according to its attack size when leveled up
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size,1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

# This will launch the projectile towards desired target
func _physics_process(delta):
	position += angle*speed*delta

func on_enemy_hit(charge = 1):
	hit_sfx.play()
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

func _on_timer_timeout():
	queue_free()
