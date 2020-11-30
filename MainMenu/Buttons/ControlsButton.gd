extends Button

var visibility

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visibility = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ControlsButton_pressed():
	if text == "Okay": text = "Controls"
	else: text = "Okay"
	get_parent().show_controls()
