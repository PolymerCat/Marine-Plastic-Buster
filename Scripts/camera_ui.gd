extends Camera2D
@onready var objective_text = $"Current Objective"

var playerRef

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef = get_parent()
	#objective_text.set_as_top_level(true) 
	#print(playerRef)


#func _process(delta):
	#objective_text.text = "Plastics x" + str(Global.score)
	#objective_text.text = "Collect x15 plastics"
