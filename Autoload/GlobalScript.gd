extends Node

var devOptions = false
var musicOption = true
var sfxOption = true
var isInGame = false
#var maniaMode = false

onready var play_screen = preload("res://GamePlaying/PlayScreen.tscn")
var play_screen_script = load("res://GamePlaying/PlayScreen.gd").new()
var boid_script = load("res://GamePlaying/BoidContainer.gd").new()
var player_agent_script = load("res://Movers/PlayerAgent.gd").new()
var main_rooms = load("res://GamePlaying/Rooms/MainRooms.gd").new()

var rooms_count = 50
var rooms_min_size = 20
var rooms_max_size = 30
var rooms_h_spread = 600
var rooms_v_spread = 300

var speed_value = 300.0
var fire_rate = 1
var bullet_velocity = 175

var ennemies_value = 0
var food_value = 10

var boids = []
var foods = []

#func _ready():
#	play_screen.instance()

func _glb_initialize():
	pass

func _set_speed_value(value):
	var v = ((value * 800) / 100)
	speed_value = clamp(v, 100, 800) 
	play_screen_script._change_move_speed_player()
	
func _set_food_value(value):
	var v = ((value * 30) / 100)
	food_value = v
	
func _set_fire_rate(value):
	var v = ((value * 10) / 100)
	fire_rate = clamp(v, 1, 30)
	#player_agent_script.set_fire_rate(int(round(v)))
	
func _set_bullet_velocity(value):
	var v = ((value * 500) / 100)
	bullet_velocity = clamp(v, 100, 500)

func _set_ennemies_value(value):
	var v = ((value * 12) / 100)
	ennemies_value = v
	
func _set_music():
	main_rooms.toggle_music()
	
func _speed_eat_food(value):
	var temp = speed_value + value
	speed_value = clamp(temp, 100, 800) 
	boids[0].max_speed = speed_value

func _get_foods():
	return foods;
	
func _get_boids():
	return boids;

func _glb_exit_game():
	MenuMusicNode.playing = GlobalScript.musicOption
	play_screen_script._empty_boids()
	boids.clear()
	speed_value = 300
	ennemies_value = 0
	isInGame = false
	get_tree().paused = false
