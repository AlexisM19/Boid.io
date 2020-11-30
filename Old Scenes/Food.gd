extends Area2D
class_name Food

var screen_size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var foods = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport().get_visible_rect().size
	
#	MUST ARRANGE SIZE 
	#position = Vector2(rand_range(0, 1024), rand_range(0, 600)) 
#	var rng = RandomNumberGenerator.new()
#	var rndX = rng.randi_range(0, screen_size.x)
#	var rndY = rng.randi_range(0, screen_size.y)	
#	position = Vector2(rndX, rndY)
	position = Vector2(rand_range(20, get_viewport().size.x - 20), rand_range(20, get_viewport().size.y - 20))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
