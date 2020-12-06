extends KinematicBody2D

export var isPlayer: = true

onready var polygon2d: Polygon2D = $PlayerShape

const DISTANCE_THRESHOLD: = 3.0

export var max_speed: = 800
export var mass: = 100
var _velocity: = Vector2.ZERO



func _ready():
	max_speed = GlobalScript.speed_value
	GlobalScript.boids.insert(0, self)
	$Camera2D/LogDev.connect("change_camera", self, "change_camera_received")

func change_camera_received(on_or_off):
	if !on_or_off:
		$Camera2D.zoom = Vector2(15, 15)
	else:
		$Camera2D.zoom = Vector2(0.75, 0.75)
		
func _process(delta):
	max_speed = GlobalScript.speed_value
	$Camera2D/LogDev/LogDev/MarginContainer/CenterContainer/SpeedLabel.text = (
		#'boids[0].max_speed = ' + str( GlobalScript.boids[0].max_speed ) + '\n' + 
		'GlobalScript.speed_value = ' + str(GlobalScript.speed_value) + '\n' + 
		#'GlobalScript.ennemies_value = ' + str(GlobalScript.ennemies_value) + '\n' + 
		#'GlobalScript.food_value = ' + str(GlobalScript.food_value) + '\n' + 
		'GlobalScript.fire_rate = ' + str(GlobalScript.fire_rate) + '\n' + 
		'GlobalScript.bullet_velocity = ' + str(GlobalScript.bullet_velocity) + '\n' + 
		'GlobalScript.rooms_count = ' + str(GlobalScript.rooms_count) + '\n' + 
		'GlobalScript.rooms_min_size = ' + str(GlobalScript.rooms_min_size) + '\n' + 
		'GlobalScript.rooms_max_size = ' + str(GlobalScript.rooms_max_size) + '\n' + 
		'GlobalScript.rooms_v_spread = ' + str(GlobalScript.rooms_v_spread) + '\n' + 
		'GlobalScript.rooms_h_spread = ' + str(GlobalScript.rooms_h_spread)
)

func _input(event):
	if GlobalScript.devOptions:
		if event.is_action_pressed('scroll_up'):
			$Camera2D.zoom = $Camera2D.zoom - Vector2(0.1, 0.1)
		if event.is_action_pressed('scroll_down'):
			$Camera2D.zoom = $Camera2D.zoom + Vector2(0.1, 0.1)
	
	
	
func _physics_process(delta: float) -> void:
	var target_global_position: Vector2 = get_global_mouse_position()
	
	if global_position.distance_to(target_global_position) < DISTANCE_THRESHOLD: 
		return
	
	_velocity = Steering.follow(
		_velocity,
		global_position,
		target_global_position,
		max_speed
	)
	_velocity = move_and_slide(_velocity)
	polygon2d.rotation = _velocity.angle()



func start_playing(var pos):
	$FollowerAgent.position = pos
