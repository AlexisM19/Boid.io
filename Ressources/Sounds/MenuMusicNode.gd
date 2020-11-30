extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalScript.musicOption:
		stream = load("res://Ressources/Sounds/Soundtrack/Nintendo 3DS Music - 3DS Menu.ogg")
		volume_db = -10
		playing = true

func toggle_music(boole):
	playing = boole
