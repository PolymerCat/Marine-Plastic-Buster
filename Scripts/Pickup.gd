extends Node2D

# THIS USES A CUSTOM RESOURCE "Item.gd"
@export var item:Item
@onready var pickup_sound = $AudioStreamPlayer2D
@onready var artwork = $Area2D/Sprite2D

# THIS INITIALIZES THE OBJECT PROPERTIES WHEN LOADED INTO THE GAME
func _ready():
	artwork.texture = item.artwork
	pickup_sound.stream = item.pickup_sound
	#var instance = item.scene.instatiate()
	#add_child(instance)

# THIS HANDLES THE PICKUP FUNCTION WHEN PLAYER TOUCHES THE OBJECT
func _on_area_2d_body_entered(body):
	if body.has_method("isPlayer"):
		print("Picked up " + item.name)
		pickup_sound.play()
		await get_tree().create_timer(0.18).timeout
		queue_free()
	
