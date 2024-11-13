extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_label = get_tree().get_first_node_in_group("loot_collected")
var experience = 0
var exp_level = 1
var collected_exp = 0
var current_loot = 0

# GUI Initializations
@onready var gui = get_tree().get_first_node_in_group("gui")
#@onready var xpBar = get_node("%xp_bar")
#@onready var label_lvl = get_node("%Label_Level")
var xpBar
var label_lvl 

func _ready():
	setXpBar(experience,calculate_exp_cap())
	label_lvl = gui.get_level_label()
	xpBar = gui.get_xp_bar()

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		#print("pickup")
		area.target = player


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		#print("pickup")
		var exp = area.collect()
		current_loot+=1
		loot_label.text = "x" + str(current_loot)
		calculate_exp(exp)
		
func calculate_exp(exp):
	var exp_required = calculate_exp_cap()
	collected_exp += exp
	if experience + collected_exp >= exp_required :
		collected_exp -= exp_required - experience
		exp_level += 1
		#label_lvl.text = str("Level: ",exp_level)
		experience = 0
		exp_required = calculate_exp_cap()
		calculate_exp(0)
	else:
		experience += collected_exp
		collected_exp = 0
	
	setXpBar(experience,exp_required)

func calculate_exp_cap():
	var exp_cap = exp_level
	if exp_level < 20:
		exp_cap = exp_level * 5
	elif exp_level < 40:
		exp_cap = 95 * (exp_level-19)*8
	else:
		exp_cap = 255 + (exp_level-39)*12
	return exp_cap

# GUI Functions
func setXpBar(set_value=1, set_max_value=100):
	#xpBar.value = set_value
	#xpBar.max_value = set_max_value
	pass
