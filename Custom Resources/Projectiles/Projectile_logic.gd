extends Area2D

# THIS USES A CUSTOM RESOURCE  "Projectiles.gd"
@export var Projectile:Projectiles
@export var speed:float
@onready var sfx = $AudioStreamPlayer2D
@onready var artwork = $CollisionShape2D/Sprite2D
@onready var hitbox = $CollisionShape2D

# THIS INITIALIZES THE OBJECT PROPERTIES WHEN LOADED INTO THE GAME
func _ready():
	sfx.stream = Projectile.projectile_sound
	artwork.texture = Projectile.artwork
	set_as_top_level(true)

# THIS HANDLES THE PROJECTILE MOTION WHEN THROWN BY PLAYER
func _physics_process(delta):
	sfx.play()
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	hitbox.rotation += 30*delta
	
# THIS WILL DESTROY THE PROJECTILE WHEN IT HITS AN ENEMY
func projectile_damage():
	queue_free()



func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
