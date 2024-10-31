extends Area2D

@export var Projectile:Projectiles
@export var speed:float
@onready var sfx = $AudioStreamPlayer2D
@onready var artwork = $CollisionShape2D/Sprite2D
@onready var hitbox = $CollisionShape2D

func _ready():
	sfx.stream = Projectile.projectile_sound
	artwork.texture = Projectile.artwork
	set_as_top_level(true)

func _physics_process(delta):
	sfx.play()
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	hitbox.rotation += 30*delta
	
	
func projectile_damage():
	queue_free()



func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
