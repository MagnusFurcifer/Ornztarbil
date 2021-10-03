extends Area


onready var original_position = self.global_transform.origin

var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_key_body_entered(body):
	if body.is_in_group("player"):
		if not triggered:
			$collect_player.play()
			triggered = true
			get_parent().activate_door()
			self.visible = false
			
