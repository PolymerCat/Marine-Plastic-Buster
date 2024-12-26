extends Control
@onready var plastic_monster = $"Beast Menu/Plastic Monster"
@onready var net_monster = $"Beast Menu/Net Monster"
@onready var boss = $"Beast Menu/Boss"
@onready var beast_desc = $"Layout/Description-Box/beast_desc"

@onready var plastic_monster_view = $"Monster View/Plastic-Monster-View"
@onready var net_monster_view = $"Monster View/Net-Monster-View"
@onready var boss_view = $"Monster View/Boss-View"
@onready var ui_click_sfx = $ui_click_sfx
@onready var ui_back_sfx = $ui_back_sfx


func _ready():
	beast_desc.text = plastic_monster.beast.description
	plastic_monster_view.visible=true
	


func _on_plasticmonsterbutton_pressed():
	ui_click_sfx.play()
	#print(plastic_monster.name)
	plastic_monster_view.visible=true
	net_monster_view.visible=false
	boss_view.visible=false
	beast_desc.text = plastic_monster.beast.description


func _on_netmonsterbutton_pressed():
	ui_click_sfx.play(0.2)
	#print(net_monster.name)
	plastic_monster_view.visible=false
	net_monster_view.visible=true
	boss_view.visible=false
	beast_desc.text = net_monster.beast.description


func _on_bossbutton_pressed():
	ui_click_sfx.play(0.2)
	#print(boss.name)
	plastic_monster_view.visible=false
	net_monster_view.visible=false
	boss_view.visible=true
	beast_desc.text = boss.beast.description

signal exit_bestiary()

func _on_exit_pressed():
	ui_back_sfx.play()
	exit_bestiary.emit()
