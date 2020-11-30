extends Node

const boids = []

onready var food_scene = preload("res://Objects/FoodBody.tscn")

func _ready():
	pass

func foodctnr_initialize():			
	if(GlobalScript.food_value > 0):
		for o in GlobalScript.food_value:
			var food = food_scene.instance()
			food.value = range(10)
			add_child(food)
			GlobalScript.foods.push_back(food)
