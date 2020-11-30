extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

var value = 0

func _ready():
	#position = Vector2(rand_range(20, get_viewport().size.x - 20), rand_range(20, get_viewport().size.y - 20))
	value = randi() % 3
	if(value < 1): value = 1
	scale.x = value
	scale.y = value

#func _ready() -> void:
	#connect("body_entered", self, "on_body_entered")

## Must be changed for event when food gets created
#func _unhandled_input(event: InputEvent) -> void:
#	if event.is_action_released("click"):
#		anim_player.play("fade_in")

# Must add removeFood()
#func on_body_entered(body: PhysicsBody2D) -> void:
#	if(!body.isPlayer):
#		pass
#	else:
#		var index = GlobalScript.foods.find(self)
#		anim_player.play("fade_out")
#		be_eat(body)
#		GlobalScript.foods.remove(index)
#		GlobalScript.food_value -= 1

func be_eat(body):
	GlobalScript._speed_eat_food(-50*value)
	body.scale.x += 0.25 * value
	body.scale.y += 0.25 * value
	
func _on_FoodBody_visibility_changed():
	if(visible == false):
		queue_free()
