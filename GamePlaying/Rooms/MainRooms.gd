extends Node2D

onready var Room = preload("res://GamePlaying/Rooms/Room.tscn")
var font = preload("res://Ressources/Fonts/raleway_medium_dyn_font.tres")
var Player = preload("res://Movers/PlayerAgent.tscn").instance()
var Follower = preload("res://Movers/FollowerAgent.tscn").instance()
onready var food_scene = preload("res://Objects/FoodBody.tscn")
onready var MusicBG = $AudioStreamPlayer
onready var Map = $TileMap

# ROOMS VAR
var tile_size = 32
var num_rooms = 0
var min_size = 20
var max_size = 30
var h_spread = 600
var v_spread = 300
var pick = 0.5			# picking room chance

# PATHS VAR
var path				# uses A* / Prim's
var start_room = null
var end_room = null
var play_mode = false
var player = null
var follower = null



func toggle_music():
	if MusicBG:
		MusicBG.playing = GlobalScript.musicOption



func _ready():
	randomize()
	make_rooms()
	min_size = GlobalScript.rooms_min_size
	max_size = GlobalScript.rooms_max_size
	h_spread = GlobalScript.rooms_h_spread
	v_spread = GlobalScript.rooms_v_spread
	MusicBG.playing = GlobalScript.musicOption
	
	
	
func make_rooms():
	num_rooms = 0
	min_size = GlobalScript.rooms_min_size
	max_size = GlobalScript.rooms_max_size
	h_spread = GlobalScript.rooms_h_spread
	v_spread = GlobalScript.rooms_v_spread
	for i in range(GlobalScript.rooms_count):
		var pos = Vector2(rand_range(-h_spread, h_spread), rand_range(-v_spread, v_spread))
		var r = Room.instance()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * tile_size)
		$Rooms.add_child(r)
	# wait for movement to stop
	yield(get_tree().create_timer(1.1), 'timeout')
	# pick rooms
	var room_positions = []
	for r in $Rooms.get_children():
		if randf() < pick:
			r.queue_free()
		else:
			r.mode = RigidBody2D.MODE_STATIC
			room_positions.append(Vector3(r.position.x, r.position.y, 0))		# since A* in godot only takes Vector3 (x, y, z)
			num_rooms += 1
	yield(get_tree(), 'idle_frame')
	# generate the minimum of paths to connect the rooms
	path = find_mst(room_positions)
	
	if GlobalScript.devOptions:
		pass
	else:
		# when devOptions not true, create automatically and spawn
		yield(get_tree().create_timer(0.2), 'timeout')
		make_map()
		position = Vector2(get_viewport().size.x /2, get_viewport().size.y/2)
		#yield(get_tree().create_timer(2), 'timeout')
		$PlayerAgent.position = start_room.position
		$FollowerAgent.position = start_room.position
		play_mode = true
	
		
		
func _draw():
	if start_room:
		draw_string(font, start_room.position - Vector2(125, 0), "Start", Color(128, 36, 200))
	if end_room:
		draw_string(font, end_room.position - Vector2(125, 0), "End", Color(128, 36, 200))
	if play_mode || !GlobalScript.devOptions:
		return
	for room in $Rooms.get_children():
		#var r = RectangleShape2D(collShapeRoom)
		draw_rect(Rect2(room.position - (room.size * 2), room.size * 2),
				  Color(228, 228, 228), false)

	if path:
		for p in path.get_points():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cp = path.get_point_position(c)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y),
						  Color(1, 1, 0), 15, true)


# Updates drawing
func _process(delta):
	update()



func _input(event):
	if event.is_action_pressed("ui_select"):
		if play_mode:
			#Player.queue_free()
			#Follower.queue_free()
			play_mode = false
		for r in $Rooms.get_children():
			r.queue_free()
		path = null
		start_room = null
		end_room = null
		Map.clear()
		make_rooms()
	if event.is_action_pressed('ui_focus_next'):
		if path:
			play_mode = true
			make_map()
	if event.is_action_pressed('ui_playing'):
		#add_child(player)
		var strtpos = start_room.position
		$PlayerAgent.position = strtpos
		$FollowerAgent.position = strtpos
		$PlayerAgent/Camera2D.zoom = Vector2(1, 1)
#		follower = Follower.instance()
#		add_child(follower)
#		follower.position = start_room.position - Vector2(10, 10)
		play_mode = true
#		for room in $Rooms.get_children():
#			room.make_food()
#			var f = food_scene.instance()
#			f.position = room.position
#			room.add_child(food_scene)
#			GlobalScript.foods.push_back(food_scene)
		
		

# Implements Prim's algorithm (find minimum spanning tree)
func find_mst(nodes):
	if num_rooms >= 2:
		var path = AStar.new()
		path.add_point(path.get_available_point_id(), nodes.pop_front())
		# repeat until no nodes left
		while nodes:
			var min_dist = INF
			var min_pos = null
			var cur_pos = null
			for point1 in path.get_points():
				point1 = path.get_point_position(point1)
				for point2 in nodes:
					if point1.distance_to(point2) < min_dist:
						min_dist = point1.distance_to(point2)
						min_pos = point2
						cur_pos = point1
			var n = path.get_available_point_id()
			path.add_point(n, min_pos)
			path.connect_points(path.get_closest_point(cur_pos), n)
			nodes.erase(min_pos)
		return path



func make_map():
	Map.clear()
	find_start_room()
	find_end_room()
	
	# filling tilemap
	var full_rect = Rect2()
	for r in $Rooms.get_children():
		var room = Rect2(r.position - r.size, 
				   r.get_node("CollisionShape2D").shape.extents * 2)
		full_rect = full_rect.merge(room)
	var top_left = Map.world_to_map(full_rect.position)
	var bottom_right = Map.world_to_map(full_rect.end)
	for x in range(top_left.x, bottom_right.x):
		for y in range(top_left.y, bottom_right.y):
			Map.set_cell(x, y, 1)
	
	var corridors = []
	for r in $Rooms.get_children():
		# create rooms in the filled map
		var size = (r.size / tile_size).floor()
		var pos = Map.world_to_map(r.position)
		var upper_left = (r.position / tile_size).floor() - size
		# starting range 6 to make sure theres walls between even close rooms
		for x in range(6, size.x * 2 - 1):
			for y in range(6, size.y * 2 - 1):
				Map.set_cell(upper_left.x + x, upper_left.y + y, 0)
		# create corridors for the rooms
		var p = path.get_closest_point(Vector3(r.position.x, r.position.y, 0))
		for link in path.get_point_connections(p):
			if not link in corridors:
				var start = Map.world_to_map(Vector2(path.get_point_position(p).x, 
											 path.get_point_position(p).y))
				var end = Map.world_to_map(Vector2(path.get_point_position(link).x, 
											 path.get_point_position(link).y))
				carve_path(start, end)
		corridors.append(p)
	


# Creates a path between two points
func carve_path(pos1, pos2):
	var x_diff = sign(pos2.x - pos1.x)
	var y_diff = sign(pos2.y - pos1.y)
	if x_diff == 0: x_diff = pow(-1.0, randi() % 2)
	if y_diff == 0: y_diff = pow(-1.0, randi() % 2)
	# choose either x/y or y/x (to draw connection between two rooms)
	var x_y = pos1
	var y_x = pos2
	if (randi() % 2) > 0:
		x_y = pos2
		y_x = pos1
	for x in range(pos1.x, pos2.x, x_diff):
		Map.set_cell(x, x_y.y, 0)
		Map.set_cell(x, x_y.y + y_diff, 0)
		Map.set_cell(x, x_y.y - y_diff, 0)
		Map.set_cell(x, x_y.y + (y_diff * 2), 0)
	for y in range(pos1.y, pos2.y, y_diff):
		Map.set_cell(y_x.x, y, 0)
		Map.set_cell(y_x.x + x_diff, y, 0)
		Map.set_cell(y_x.x - x_diff, y, 0)
		Map.set_cell(y_x.x + (x_diff * 2), y, 0)
	
	
	
func find_start_room():
	var min_x = INF
	for r in $Rooms.get_children():
		if r.position.x < min_x:
			start_room = r
			min_x = r.position.x



func find_end_room():
	var max_x = -INF
	for r in $Rooms.get_children():
		if r.position.x > max_x:
			end_room = r
			max_x = r.position.x
	
	
	
