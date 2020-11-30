extends Sprite

var new_color : Color

onready var viewportWidth = get_viewport().size.x
onready var viewportHeight = get_viewport().size.y
onready var scaling = viewportWidth / texture.get_size().x

func _ready() -> void:
	randomize()
	modulate = (Color(randf(), randf(), randf(), 1.0))
	new_color = (Color(randf(), randf(), randf(), 1.0))
	set_scale(Vector2(scaling, scaling))
	set_position(Vector2(viewportWidth/2, viewportHeight/2))
	
func _process(delta: float) -> void:
	modulate = lerp(modulate, new_color, 0.0015)

func _on_Timer_timeout() -> void:
	new_color = (Color(randf(), randf(), randf(), 1.0))

#func _process(delta):
#	pass
