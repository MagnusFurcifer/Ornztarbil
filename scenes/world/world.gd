extends Spatial


enum {
	PRE,
	INGAME,
	POST
}
var game_state = PRE

var elapsed = 0 #Stopwatch

func _ready():
	GameManager.world_manager = self
	$player.global_transform.origin = $player.global_transform.origin + Vector3(0, 100, 0)
	GameManager.player = $player
	setup_world()
	
func _input(event):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func progress_game_state():
	if game_state == PRE:
		game_state = INGAME
		elapsed = 0 #Stopwatch
	elif game_state == POST:
		next_level()
	
	
func _process(delta):
	if game_state == INGAME: #Stopwatch
		elapsed += delta; #Stopwatch
		GameManager.player.update_current_time("%0.2f" % elapsed)
	
func next_level():
	print("Next Level Called")
	GameManager.level_times[GameManager.current_level] = str("%0.2f" % elapsed)
	print("Elapsed: " + str(elapsed))
	print("Current Level: " + str(GameManager.current_level))
	GameManager.next_level()
	print("Next Level: " + str(GameManager.current_level))
	if GameManager.current_level >= GameManager.level_array.size():
		print("End of level array, changing to end")
		get_tree().change_scene("res://scenes/menus/end_menu/end_menu.tscn")
	else:
		for i in $nodes.get_children():
			print(i)
			i.queue_free()
		if OS.get_name() == "HTML5":
			get_tree().change_scene("res://scenes/menus/loading_screen/loading_screen_fake.tscn")
			pass
		else:
			LoadingScreen.load_scene("res://scenes/world/world.tscn")
	
	
func setup_world():
	var level = GameManager.get_level().instance()
	$nodes.add_child(level)
	reset_player_position()
	
	
func entity_detected(body):
	pass
	
func player_finished():
	print("FINISHED")
	game_state = POST
	
func reset_player_position():
	$player.global_transform.origin = $nodes/map/player_one_start/spawn.global_transform.origin
	$player.look_at($nodes/map/player_one_start/look_at_target.global_transform.origin, Vector3.UP)	
	
func on_death_box_body_entered(body):
	if game_state != POST:
		#print("Death box entered")
		if body.is_in_group("player"):
			game_state = PRE
			body.play_death_sound()
			$nodes/map.reset_map()
			reset_player_position()
		
func player_restart():
	if game_state != POST:
		game_state = PRE
		$nodes/map.reset_map()
		reset_player_position()
