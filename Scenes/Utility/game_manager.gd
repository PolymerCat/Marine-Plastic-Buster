extends Node2D
#@onready var timer_label = $TimerLabel

@onready var timeBar = get_tree().get_first_node_in_group("timebar")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var timer_label = get_tree().get_first_node_in_group("timelabel")
@onready var timer = $Timer

var round_time = 5
var rounds = 1

func _ready():
	timer.wait_time=round_time
	timeBar.max_value=round_time
	timer.start()
	
func _process(delta):
	timer_label.text = str(int(timer.time_left))
	timeBar.value = timer.time_left
	
	if player.hp<=0:
		get_tree().quit()

func time_left():
	var time = timer.time_left
	return time

func _on_timer_timeout():
	if rounds<=5:
		rounds+=1
		round_time+=1
		timer.start(round_time)
		
	elif rounds>5: # THIS WILL ACTIVATE THE FINAL ROUND
		get_tree().quit()
	
	
