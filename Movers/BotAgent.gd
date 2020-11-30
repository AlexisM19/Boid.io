extends KinematicBody2D

onready var polygon2d: Polygon2D = $BotShape

const DISTANCE_THRESHOLD: = 3.0

export var max_speed: = 300
export var mass: = 100
var _velocity: = Vector2.ZERO

func _ready():
	randomize()
	position = Vector2(rand_range(0, get_viewport().size.x), rand_range(0, get_viewport().size.y))
	max_speed = 600
	
