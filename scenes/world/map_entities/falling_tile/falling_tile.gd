extends StaticBody

enum {
	GREEN,
	RED,
	GONE
}
export var starting_phase = GREEN

onready var green_mesh = $green
onready var red_mesh = $red
onready var stood_on_timer = $stood_on_timer
onready var tile_phase = starting_phase
onready var origin_location = global_transform.origin
onready var falling_tween = $falling_tween

# Called when the node enters the scene tree for the first time.
func _ready():
	#The tile starts a bit low so it can come tween at the start
	global_transform.origin = origin_location - Vector3(0, 50, 0)
	
	
func block_enable():
	falling_tween.stop_all()
	if starting_phase == GREEN:
		tile_phase = GREEN
		set_mesh_visibility(true, false)
	elif starting_phase == RED:
		tile_phase = RED
		set_mesh_visibility(false, true)
	self.visible = true
	randomize()
	var speed = rand_range (0.5, 1)
	falling_tween.interpolate_property(
		self, "translation", global_transform.origin, origin_location, speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	falling_tween.start()
	
func block_disable():
	randomize()
	var speed = rand_range (1, 2)
	falling_tween.interpolate_property(
		self, "translation", global_transform.origin, origin_location - Vector3(0, 50, 0), speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	falling_tween.start()

	
func set_mesh_visibility(green, red):
	green_mesh.visible = green
	red_mesh.visible = red
	
func next_mesh_phase():
	if tile_phase == GREEN:
		tile_phase = RED
		set_mesh_visibility(false, true)
	elif tile_phase == RED:
		tile_phase = GONE
		block_disable()
	
func _on_entity_detector_body_entered(body):
	if body.is_in_group("entity"):
		stood_on_timer.start()
		GameManager.world_manager.entity_detected(body)
		
func _on_entity_detector_body_exited(body):
	stood_on_timer.stop()
	next_mesh_phase()
	
func _on_stood_on_timer_timeout():
	next_mesh_phase()
	stood_on_timer.start()


func _on_falling_tween_tween_all_completed():
	if tile_phase == GONE:
		self.visible = false
