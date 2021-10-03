extends StaticBody

onready var door_tween = $Tween
onready var original_position = self.global_transform.origin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func activate_door():
	randomize()
	var speed = rand_range (2, 4)
	door_tween.interpolate_property(
		self, "translation", global_transform.origin, original_position + Vector3(0, 2, 0), speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	door_tween.start()
	
func reset_door():
	randomize()
	var speed = rand_range (2, 4)
	door_tween.interpolate_property(
		self, "translation", global_transform.origin, original_position, speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	door_tween.start()
	$key.visible = true
	$key.triggered = false
	pass
