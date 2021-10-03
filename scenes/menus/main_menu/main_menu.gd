extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
 

func _on_Button_pressed():
	if OS.get_name() == "HTML5":
		get_tree().change_scene("res://scenes/world/world.tscn")
		pass
	else:
		LoadingScreen.load_scene("res://scenes/world/world.tscn")
