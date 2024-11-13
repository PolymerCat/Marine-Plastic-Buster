extends CharacterBody2D
@onready var raycast = $RayCast2D
@onready var footstep_sfx = $AudioStreamPlayer2D
@onready var timer = $Timer
@onready var marker_2d = $Marker2D

# SOME PLAYER VARIABLES LIKE STATS
const SPEED = 150.0
const DASH_SPEED = 500.0
const JUMP_VELOCITY = -400.0
var projectile_cooldown = true
var hp=80


var combat_mode = true

# PRELOAD WEAPONS
var lighter = preload("res://Custom Resources/Projectiles/Lighter_Projectile.tscn")

# THIS FUNCTION IS FOR THE MOUSE AIMING AND SHOOTING
func playerRaycast():
	if Input.get_action_strength("gameplay_aim"):
		var mousePos = get_local_mouse_position()
		raycast.target_position = mousePos
		marker_2d.look_at(mousePos)
		#raycast.draw_line(raycast.position, mousePos,Color.AQUA,true)
		if combat_mode:
			if Input.is_action_just_pressed("gameplay_shoot") and projectile_cooldown:
				projectile_cooldown=false
				#lighter.sfx.play()
				var projectileInstance = lighter.instantiate()
				projectileInstance.look_at(mousePos)
				projectileInstance.global_position = marker_2d.global_position
				add_child(projectileInstance)
				await get_tree().create_timer(0.6).timeout
				projectile_cooldown=true
			

# THIS IS JUST A SIMPLE FUNCTION TO IDENTIFY THE PLAYER
func isPlayer():
	pass

# THIS FUNCTION IS FOR SWITCHING BETWEEN MELEE AND RANGED COMBAT
func weaponSwitch():
	if Input.get_action_strength("gameplay_weapon1"): 
		combat_mode=true
		print("toggle ranged")
	if Input.get_action_strength("gameplay_weapon2"):
		combat_mode=false
		print("toggle melee")

# WHEN THE PLAYER DIES, GAME OVER
func gameover_condition():
	if Global.player_health <=0:
		get_tree().quit()

func movement():
	var direction = Input.get_vector("gameplay_left","gameplay_right","gameplay_up","gameplay_down")
	velocity = direction.normalized()*SPEED
	move_and_slide()
	
	if direction:
		# this is for footstep sfx
		if timer.time_left <= 0:
			footstep_sfx.pitch_scale = randf_range(0.8,1.2)
			footstep_sfx.play()
			timer.start(0.4)

# THIS FUNCTION HANDLES PLAYER MOVEMENT
func _physics_process(delta):
	movement()
	playerRaycast()
	#weaponSwitch()
	gameover_condition()

# THIS HANDLES INPUT FOR DASHING
func _process(delta):
	pass
	#if Input.is_action_just_pressed("gameplay_dash") :
		#print("dash!")
		#isDashing=true
		#await get_tree().create_timer(0.3).timeout
		#isDashing=false


func _on_hurtbox_hurt(damage, _angle, _knockback):
	hp -= damage
	print(hp)


