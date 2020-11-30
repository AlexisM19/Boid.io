extends RigidBody2D

var size


func make_room(_pos, _size):
	position = _pos
	size = _size
	var s = RectangleShape2D.new()
	s.custom_solver_bias = 0.75
	# extends = half width
	s.extents = size
	$CollisionShape2D.shape = s
	#$CollisionShape2D.rotation_degrees = 90
	#GlobalScript.collShapeRoom = s
