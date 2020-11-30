extends Node

var is_ready = false

#export var BOTS_COUNT: = 5
export var boids = []
var speed = 800

onready var player_scene = preload("res://Movers/PlayerAgent.tscn")
onready var bot_scene = preload("res://Movers/BotAgent.tscn")

func _ready():
#	var player = player_scene.instance()
#	player.max_speed = GlobalScript.speed_value
#	add_child(player)
#	boids.push_back(player)
	pass
	

func boidctnr_get_boids():
	return boids;

func boidctnr_initialize():
	if(GlobalScript.ennemies_value > 0):
		for i in GlobalScript.ennemies_value:
			var bot = bot_scene.instance()
			add_child(bot)
			boids.push_back(bot)
	boids[0].max_speed = GlobalScript.speed_value

func _change_move_speed(var bdnb):
	#GlobalScript._set_speed_value(bdsp)
	if(!boids.empty()):
		boids[bdnb].max_speed = GlobalScript.speed_value

func _boids_empty_boids():
	boids.clear()
