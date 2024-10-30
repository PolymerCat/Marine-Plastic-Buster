extends CharacterBody2D
@onready var raycast = $RayCast2D
@onready var footstep_sfx = $AudioStreamPlayer2D
@onready var timer = $Timer


const SPEED = 300.0
const DASH_SPEED = 400.0
const JUMP_VELOCITY = -400.0
var isDashing = false

func playerRaycast():
	if Input.get_action_strength("gameplay_aim"):
		var mousePos = get_local_mouse_position()
		raycast.target_position = mousePos
		#raycast.draw_line(raycast.position, mousePos,Color.AQUA,true)

func isPlayer():
	pass

func weaponSwitch():
	var isMelee = true
	if Input.get_action_strength("gameplay_weapon1"): 
		isMelee=true
		
	if Input.get_action_strength("gameplay_weapon2"):
		isMelee=false
		
func gameover_condition():
	if Global.health <=0:
		get_tree().quit()

func _physics_process(delta):
	# get dash button pressed
	var dashPressed = Input.get_action_strength("gameplay_dash")
	if dashPressed>0:
		isDashing = true
	else : isDashing = false
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("gameplay_left","gameplay_right","gameplay_up","gameplay_down")
	if direction:
		# this is for footstep sfx
		if timer.time_left <= 0:
			footstep_sfx.pitch_scale = randf_range(0.8,1.2)
			footstep_sfx.play()
			if isDashing:
				timer.start(0.3)
			else : timer.start(0.4)
		if isDashing:
			velocity = direction * DASH_SPEED
		else: velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	playerRaycast()
	weaponSwitch()
	gameover_condition()



func _on_hitbox_area_entered(area):
	if area.has_method("damagePlayer"):
		print(Global.health)
		Global.health -= 1
		#get_tree().quit()
