extends KinematicBody




var default_footstep_streams = [
	load("res://scenes/entities/player/assets/foot_steps/default/1.wav"),
	load("res://scenes/entities/player/assets/foot_steps/default/2.wav"),
	load("res://scenes/entities/player/assets/foot_steps/default/3.wav"),
	load("res://scenes/entities/player/assets/foot_steps/default/4.wav"),
	load("res://scenes/entities/player/assets/foot_steps/default/5.wav"),
	load("res://scenes/entities/player/assets/foot_steps/default/6.wav"),
	load("res://scenes/entities/player/assets/foot_steps/default/7.wav"),
]







var sprint_speed = 8
var run_speed = 4
var speed = 4
const ACCEL_DEFAULT = 10
const ACCEL_AIR = 1
onready var accel = ACCEL_DEFAULT
var gravity = 9.8
var water_float_coe = 2
var jump = 2.5
var is_on_float_area = false
var current_float_y = -0.5

var npcs_in_interact_area = []

var cam_accel = 40
var mouse_sense = 0.1
var snap


var angular_velocity = 30

var direction = Vector3()
var velocity = Vector3()
var gravity_vec = Vector3()
var movement = Vector3()


onready var arm = $head/Camera/arm

onready var head = $head

enum {
	IDLE,
	RUNNING,
	SPRINTING,
	FALLING
}

var current_state = IDLE

var function_has_boosted = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if GameManager.world_manager.game_state == GameManager.world_manager.INGAME:
		#get mouse input for camera rotation
		if event is InputEventMouseMotion:
			rotate_y(deg2rad(-event.relative.x * mouse_sense))
			head.rotate_x(deg2rad(-event.relative.y * mouse_sense))
			head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
		pass
		
		if Input.is_action_just_pressed("action_shoot"):
			arm.shoot()
			pass
	else:
		if Input.is_action_just_pressed("action_shoot"):
			GameManager.world_manager.progress_game_state()
			
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("action_restart"):
		GameManager.world_manager.player_restart()

func play_death_sound():
	$footstep_stuff/death_sound.play()

func update_current_time(current_time):
	$head/Camera/Control/post_ui/time.text = "Level Time: " + str(current_time) + " seconds"
	pass

func _process(delta):
		
	if current_state == SPRINTING:
		speed = sprint_speed
		foot_step(0.05)
	elif current_state == RUNNING:
		speed = run_speed
		foot_step(0.1)
		
	if GameManager.world_manager.game_state == GameManager.world_manager.PRE:
		$head/Camera/Control/pre_ui.visible = true
		$head/Camera/Control/post_ui.visible = false
	elif GameManager.world_manager.game_state == GameManager.world_manager.INGAME:
		$head/Camera/Control/pre_ui.visible = false
		$head/Camera/Control/post_ui.visible = false
	elif GameManager.world_manager.game_state == GameManager.world_manager.POST:
		$head/Camera/Control/pre_ui.visible = false
		$head/Camera/Control/post_ui.visible = true
		
func foot_step(timeout):
	if !$footstep_stuff/walk_player.playing:
		if $footstep_stuff/walk_timeout.time_left == 0:
			$footstep_stuff/walk_player.stream = default_footstep_streams[randi() % default_footstep_streams.size()]
			$footstep_stuff/walk_player.play()
			
			
func _on_walk_player_finished():
	$footstep_stuff/walk_timeout.start()
		
		
func jump_pad_activate(boost_str):
	print("Jump pad activate")
	velocity.y = boost_str
	function_has_boosted = true
		
func _physics_process(delta):
	if GameManager.world_manager.game_state == GameManager.world_manager.INGAME:
		direction = Vector3.ZERO
		var h_rot = global_transform.basis.get_euler().y
		var f_input = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
		var h_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		direction = Vector3(h_input, 0, f_input).rotated(Vector3.UP, h_rot).normalized()
			
		#jumping and gravity
		if is_on_floor():
			snap = -get_floor_normal()
			accel = ACCEL_DEFAULT
			gravity_vec = Vector3.ZERO
			if current_state == FALLING:
				current_state = IDLE
		else:
			snap = Vector3.DOWN
			accel = ACCEL_AIR
			gravity_vec += Vector3.DOWN * gravity * delta
			if gravity_vec.y < 0.1:
				current_state = FALLING
				
		if current_state != FALLING:
			if direction.x == 0 and direction.z == 0:
				current_state = IDLE
			else:
				if Input.is_action_pressed("move_sprint"):
					current_state = SPRINTING
				else:
					current_state = RUNNING
		
		#make it move
		velocity = velocity.linear_interpolate(direction * speed, accel * delta)
		movement = velocity + gravity_vec
		
		move_and_slide(movement, Vector3.UP)
		
		#landing sound after a jump pad boost
		if is_on_floor():
			if function_has_boosted:
				$footstep_stuff/boost_land_sound.play()
				function_has_boosted = false
