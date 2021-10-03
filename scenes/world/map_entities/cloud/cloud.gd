extends Spatial


onready var cloud_move_tween = $Tween

var min_speed = 32
var max_speed = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var speed = rand_range (min_speed, max_speed)
	cloud_move_tween.interpolate_property(
		self, "translation", global_transform.origin, global_transform.origin + Vector3(0, 0, 128), speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	cloud_move_tween.start()
	
	
	
func _on_Tween_tween_all_completed():
	print("Cloud finished")
	self.queue_free()
