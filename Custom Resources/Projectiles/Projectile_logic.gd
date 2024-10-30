extends Area2D

@export var projectile:Projectiles
@onready var throw_sound = $AudioStreamPlayer2D
@onready var artwork = $Area2D/Sprite2D

func _ready():
	artwork = projectile.artwork
	throw_sound = projectile.projectile_sound
	



func _on_body_entered(body):
	if body.has_method("enemy") or body.has_method("player"):
		print("hit!")
