extends Area2D

@export_enum("Cooldown","HitOnce","DisableHitbox") var HurtboxType = 0

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer


# CUSTOM SIGNAL TO RECEIVE DAMAGE
signal hurt(damage,angle,knockback)

var hit_once_array = []

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match HurtboxType:
				0: #Cooldown
					collision.call_deferred("set","disabled",true)
					disable_timer.start()
				1: #HitOnce
					if hit_once_array.has(area) == false:
						hit_once_array.append(area)
						if not area.has_signal("remove_from_array"):
							if not area.is_connected("remove_from_array",Callable(self,"remove_from_list")):
								area.connect("remove_from_array",Callable(self,"remove_from_list"))
					else:
						return
				2: #DisableHitbox
					if area.has_method("tempDisable"):
						area.tempDisable()
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:
				knockback = area.knockback_amount
			emit_signal("hurt",damage,angle,knockback)
			if area.has_method("on_enemy_hit"):
				area.on_enemy_hit(1)

func remove_from_list(object):
	if hit_once_array.has(object):
		hit_once_array.erase(object)
	

# WILL ACTIVATE WHEN DISABLE TIMER STOPS
func _on_disable_timer_timeout():
	collision.call_deferred("set","disabled",false)