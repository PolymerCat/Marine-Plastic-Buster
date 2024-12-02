extends Label

# Reference to the player node
var player: Node = null

func _ready():
	# Find the player node (assumes it is named "Player" and is in the scene tree)
	player = get_node("/root/Global/level_1/Player")
	# Optionally set an initial value
	update_speed_display()

func _process(delta):
	# Update the label every frame to reflect the current speed
	if player != null:
		update_speed_display()

func update_speed_display():
	if player:
		print("Player's speed: ", player.SPEED)  # Access the SPEED variable
	else:
		print("Player not found!")
		
	if player == null:
		text = "0"
	else:
		text = str(player.speed)
