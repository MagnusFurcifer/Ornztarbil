extends Spatial


func _ready():
	GameManager.world_manager = self
	$player.global_transform.origin = $player.global_transform.origin + Vector3(0, 100, 0)
	GameManager.player = $player
	setup_world()
	
func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
func setup_world():
	var level = GameManager.get_level().instance()
	print("Loading and adding level")
	$nodes.add_child(level)
	reset_player_position()
	
	
func entity_detected(body):
	pass
	
func player_finished():
	print("FINISHED")
	for i in $nodes.get_children():
		print(i)
		i.queue_free()
	GameManager.next_level()
	if OS.get_name() == "HTML5":
		get_tree().change_scene("res://scenes/world/world.tscn")
		pass
	else:
		LoadingScreen.load_scene("res://scenes/world/world.tscn")
	
func reset_player_position():
	$player.global_transform.origin = $nodes/map/player_one_start/spawn.global_transform.origin
	$player.look_at($nodes/map/player_one_start/look_at_target.global_transform.origin, Vector3.UP)	
	
func on_death_box_body_entered(body):
	#print("Death box entered")
	if body.is_in_group("player"):
		$nodes/map.reset_map()
		reset_player_position()
		
func player_restart():
	$nodes/map.reset_map()
	reset_player_position()
