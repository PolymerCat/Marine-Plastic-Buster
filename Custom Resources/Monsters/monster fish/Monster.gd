extends CharacterBody2D
@onready var hitboxReal = $hitbox
@onready var hitbox = $hitbox/CollisionShape2D
@onready var detection_area = $detection_area/CollisionShape2D
@onready var sfx = $AudioStreamPlayer2D

@export var monster_data = Monster

var speed = 1
var health = 4
var damage = 0
var isDead = false

# FOR PLAYER DETECTION
var player
var player_detected = false


func _ready():
	isDead = false
	health = monster_data.health

func _physics_process(delta):
	if !isDead:
		detection_area.disabled=false
		if player_detected:
			var target_pos = player.position - position
			position += (target_pos) * delta
	if isDead:
		detection_area.disabled=true
		hitbox.disabled=true
		position += Vector2(0,0)
	
	#move_and_slide()

func damagePlayer():
	pass

func enemy():
	pass

func _on_detection_area_body_entered(body):
	if body.has_method("isPlayer"):
		player_detected=true
		player = body


func _on_detection_area_body_exited(body):
	if body.has_method("isPlayer"):
		player_detected=false

func _on_hitbox_area_entered(area):
	if area.has_method("projectile_damage"):
		health -= 1
		print(health)
		if health<=0:
			position += Vector2(0,0)
			sfx.stream=monster_data.death_sound_mp3
			sfx.play()
			await get_tree().create_timer(1).timeout
			queue_free()

