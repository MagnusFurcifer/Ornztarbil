extends StaticBody

onready var door_tween = $Tween
onready var original_position = self.global_transform.origin

export var door_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func activate_door():
	randomize()
	door_tween.interpolate_property(
		self, "translation", global_transform.origin, original_position + Vector3(0, 2, 0), door_speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	door_tween.start()
	
func reset_door():
	door_tween.stop_all()
	randomize()
	var speed = rand_range (1, 1)
	door_tween.interpolate_property(
		self, "translation", global_transform.origin, original_position, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	door_tween.start()
	$key.visible = true
	$key.triggered = false
	pass


func _on_Tween_tween_all_completed():
	#if $key.triggered == false:
	#	$key.visible = true
	pass
