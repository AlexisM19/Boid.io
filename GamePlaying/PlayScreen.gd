extends Node


export var boids = []

#onready var boid_scene = preload("res://Boid.tscn")
#onready var food_scene = preload("res://Food.tscn")
onready var boids_container = $BoidContainer
onready var foods_container = $FoodContainer
var boid_script = load("res://GamePlaying/BoidContainer.gd").new()
#onready var foods_container = $Foods

func _ready():
	$"/root/MenuMusicNode".playing = false
	if GlobalScript.devOptions:
		$Label.visible = false
	GlobalScript.isInGame = true
	#preload("res://Agents/BoidAgent.tscn")
	#load("res://GamePlaying/BoidContainer.tscn")
	#foods_container.foodctnr_initialize()
	#boids_container.boidctnr_initialize()
	
func _change_move_speed_player():
	boid_script._change_move_speed(0)

func _empty_boids():
	boid_script._boids_empty_boids()
