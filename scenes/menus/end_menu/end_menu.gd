extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer/time_0.text = "Level 1: " + GameManager.level_times[0] + " seconds."
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer/time_1.text = "Level 2: " + GameManager.level_times[1] + " seconds."
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer/time_2.text = "Level 3: " + GameManager.level_times[2] + " seconds."
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer/time_3.text = "Level 4: " + GameManager.level_times[3] + " seconds."
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer/time_4.text = "Level 5: " + GameManager.level_times[4] + " seconds."
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer2/time_5.text = "Level 6: " + GameManager.level_times[5] + " seconds."
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer2/time_6.text = "Level 7: " + GameManager.level_times[6] + " seconds."
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer2/time_7.text = "Level 8: " + GameManager.level_times[7] + " seconds."
	$Camera/Control/Control/TIMES/HSplitContainer/VBoxContainer2/time_8.text = "Level 9: " + GameManager.level_times[8] + " seconds."
	


func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
 

func _on_Button_pressed():
	GameManager.current_level = 0
	if OS.get_name() == "HTML5":
		get_tree().change_scene("res://scenes/menus/main_menu/main_menu.tscn")
		pass
	else:
		LoadingScreen.load_scene("res://scenes/menus/main_menu/main_menu.tscn")


func _on_Button2_pressed():
	get_tree().quit()
