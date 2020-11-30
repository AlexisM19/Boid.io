extends KinematicBody2D

export var isPlayer: = false

onready var polygon2d: Polygon2D = $Polygon2D1
onready var target: = get_node(target_path)

const ARRIVE_THRESHOLD: = 3.0

export var target_path: = NodePath()
export var follow_offset: = 100.0

export var max_speed: = 800
export var mass: = 100
var _velocity: = Vector2.ZERO

#func _ready():
#	position.x = 600
#	position.y = 400
	
func _physics_process(delta: float) -> void:
	if target == self:
		set_physics_process(false)
		
	var target_global_position: Vector2 = target.global_position
	#$Particles2D.rotation = target_global_position.rotation
	
	var to_target: = global_position.distance_to(target_global_position)
	if to_target < ARRIVE_THRESHOLD: 
		return
		
	var follow_global_position: Vector2 = (
		target_global_position - (target_global_position - global_position).normalized() * 
		follow_offset
		if to_target > follow_offset
		else global_position
	)
	
	_velocity = Steering.arrive_to(
		_velocity,
		global_position,
		follow_global_position,
		max_speed,
		200.0,
		200.0
	)
	
	_velocity = move_and_slide(_velocity)
	polygon2d.rotation = _velocity.angle()
