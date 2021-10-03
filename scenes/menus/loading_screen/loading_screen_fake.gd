extends Control


onready var progress = $Progress

func _ready():
	randomize()
	progress.percent_visible = false
	self.visible = true
	
func _process(delta):
	var percentage = ($fake_loading_timer.time_left / $fake_loading_timer.wait_time)
	print(percentage)
	progress.value = percentage * 100


func _on_fake_loading_timer_timeout():
	get_tree().change_scene("res://scenes/world/world.tscn")
