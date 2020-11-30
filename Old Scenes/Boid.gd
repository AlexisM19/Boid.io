extends Area2D
class_name Boid

signal hit

var boids = []
var move_speed = 200
var velocity = Vector2()
var acceleration = Vector2()
var steer_force = 50.0
var cohesion_force = 0.6
		
var foodss = []

func _ready():
	randomize()
	
#	position = Vector2(rand_range(0, get_viewport().size.x), rand_range(0, get_viewport().size.y))
#	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * move_speed
	
	


#func _process(delta):	
	
	#acceleration += process_cohesion(get_parent().get("foods")) * cohesion_force
	
#	velocity += acceleration * delta
#	velocity = velocity.clamped(move_speed)
#	rotation = velocity.angle()
#
#	translate(velocity * delta)
#
#	position.x = wrapf(position.x, -32, get_viewport().size.x + 32)
#	position.y = wrapf(position.y, -32, get_viewport().size.y + 32)	
#
#
#func process_cohesion(foodss):
#	var vector = Vector2()
#	for food in foodss:
#		vector += food.position
#	vector /= foodss.size()
#	return steer((vector - position).normalized() * move_speed)


#func steer(var target):
#	var steer = target - velocity
#	steer = steer.normalized() * steer_force
#	return steer
	
#func _on_Player_body_entered(body):
#	hide()
#	emit_signal("hit")
#	$CollisionShape2D.set_deferred("disabled", true)
#
#func _on_Area2D_body_entered(body):
#	hide()
#	emit_signal("hit")
#	$CollisionShape2D.set_deferred("disabled", true)
