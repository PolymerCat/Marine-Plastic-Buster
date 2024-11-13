extends Area2D

# THIS USES A CUSTOM RESOURCE "Item.gd"
@export var item:Item
@onready var pickup_sound = $AudioStreamPlayer2D
@onready var artwork = $Sprite2D
@export var experience = 1
@onready var collision = $collision


var target = null
var speed = -1

# THIS INITIALIZES THE OBJECT PROPERTIES WHEN LOADED INTO THE GAME
func _ready():
	artwork.texture = item.artwork
	pickup_sound.stream = item.pickup_sound
	experience = item.experience
	#var instance = item.scene.instatiate()
	#add_child(instance)

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position , speed)
		speed += 2*delta

func collect():
	pickup_sound.play()
	collision.call_deferred("set","disabled",true)
	artwork.visible = false
	return experience

# THIS PART IS NO LONGER USED
# THIS HANDLES THE PICKUP FUNCTION WHEN PLAYER TOUCHES THE OBJECT
#func _on_area_2d_body_entered(body):
	#if body.has_method("isPlayer"):
		#print("Picked up " + item.name)
		#pickup_sound.play()
		#await get_tree().create_timer(0.18).timeout
		#queue_free()
	


func _on_audio_stream_player_2d_finished():
	queue_free()
