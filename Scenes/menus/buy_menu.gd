extends Control

func show_buy_menu():
	print("Hi") # Make the buy menu visiblevisible = true  # Make the buy menu visible
	get_tree().paused = true

func hide_buy_menu():
	# visible = false
	get_tree().paused = false  # Resume the game when the menu is closed

func _process(delta):
	show_buy_menu()

func _on_continue_pressed():
	hide_buy_menu()
