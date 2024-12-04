extends CharacterBody2D

@export var movement_speed = 80.0
@export var hp=100
@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var animator = $animator
@onready var attack_sfx = $attack_sfx
@onready var die_sfx = $die_sfx
@onready var footstep_sfx = $footstep_sfx
@onready var health_bar = $health_bar
#@onready var hitbox = $Hitbox
@onready var hitbox = $Hitbox/CollisionShape2D
@onready var animator_real = $animator2
@onready var boss_sprite = $boss_sprite
@onready var hit_flash_player = $hit_flash_player


var attack_loop = 0
var experience = 1

var loot_drop = preload("res://Scenes/item scenes/pickup_plastic.tscn")

func _ready():
	hit_flash_player.play("hit_flash")
	health_bar.max_value=hp
	hitbox.disabled = true
	health_bar.value = hp

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	print(direction)
	velocity = direction * movement_speed
	if direction.x>0:
		boss_sprite.flip_h=true
	else:
		boss_sprite.flip_h=false

	
	move_and_slide()

func _process(delta):
	
	
	if velocity and  !footstep_sfx.playing:
		footstep_sfx.play()
	elif not velocity:
		footstep_sfx.playing = false

func attack():
	set_physics_process(false)
	set_process(false)
	footstep_sfx.playing = false
	if attack_loop==1:
		animator_real.play("attack")
		
	#hitbox.disabled= false

func reset_attack():
	set_physics_process(true)
	set_process(true)
	#animator_real.play("walk")
	#hitbox.disabled= true


func death():
	set_physics_process(false)
	emit_signal("remove_from_array", self)
	set_process(false)
	footstep_sfx.playing = false
	animator_real.play("die")
	die_sfx.play(1.05)
	await get_tree().create_timer(2).timeout
	var new_loot = loot_drop.instantiate()
	new_loot.global_position = global_position
	new_loot.experience = experience
	loot_base.call_deferred("add_child",new_loot)
	queue_free()

func _on_hurtbox_hurt(damage, angle, knockback):
	hit_flash_player.play("hit_flash")
	hp -= damage
	health_bar.value = hp
	if hp<=0:
		death()


func _on_detector_area_entered(area):
	if area.is_in_group("player"):
		attack_loop=1
		attack()
		#print("player entered attack area")
		#print("attack = " + str(attack_loop))


func _on_detector_area_exited(area):
	if area.is_in_group("player"):
		animator_real.play("walk")
		await get_tree().create_timer(0.5).timeout
		reset_attack()
		attack_loop=0
		#print("attack = " + str(attack_loop))
		
		
