extends Node2D
#@onready var timer_label = $TimerLabel

# THIS IS USED TO REFERENCE THE UI FOR THE TIMER 
@onready var timeBar = get_tree().get_first_node_in_group("timebar")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var timer_label = get_tree().get_first_node_in_group("timelabel")
@onready var gui = get_tree().get_first_node_in_group("gui")
@onready var gui_anim = get_tree().get_first_node_in_group("gui_anim")

@onready var timer = $Timer
@onready var audio = $audio

var round_time = 10
var rounds = 1

func _ready():
	timer.wait_time=round_time
	#timeBar.max_value=round_time
	gui.time_bar.max_value=round_time
	timer.start()
	
	
func _process(delta):
	# Updates the GUI in real time according to the timer
	gui.time_label.text = str(int(timer.time_left))
	timeBar.value = timer.time_left
	gui.time_bar.value = timer.time_left
	
	# Will play clock ticking sound when 10 seconds left
	if audio.playing:
		pass
	elif not audio.playing and timer.time_left <=10:
		audio.play(6.0)
		gui_anim.play("timer_ending")
	else:
		gui_anim.play("RESET")
	
	if player.hp<=0:
		get_tree().quit()

func time_left():
	var time = timer.time_left
	return time

func _on_timer_timeout():
	# Each new round will increase in time
	if rounds<=5:
		rounds+=1
		round_time+=5
		round_end.emit(true)
		#timer.start(round_time)
		
	elif rounds>5: # THIS WILL ACTIVATE THE FINAL ROUND
		get_tree().quit()
	
signal round_end(game_state)


func _on_buy_menu_done_buy():
	timer.start(round_time)
