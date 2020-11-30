extends HBoxContainer

signal value_changed

onready var play_screen = load("res://GamePlaying/PlayScreen.gd").new()
signal move_speed_changed
signal ennemies_count_changed
signal food_count_changed

func _ready():
	$HSlider.connect("value_changed", self, "on_slider_changed")
	$Value.text = str($HSlider.value)
	
	self.connect("move_speed_changed", play_screen, "_change_move_speed_player")
	self.connect("ennemies_count_changed", play_screen, "_ennemies_count_changed_extern")
	self.connect("food_count_changed", play_screen, "_food_count_changed_extern")

func on_slider_changed(value):
	$Value.text = str(value)
	emit_signal("value_changed", value)

func _on_ennemies_count_value_changed(value):
	GlobalScript._set_ennemies_value(value)

func _on_food_count_value_changed(value):
	GlobalScript._set_food_value(value)

func _on_MoveSpeed_move_speed_changed(value):
	GlobalScript._set_speed_value(value)

func _on_fire_rate_value_changed(value):
	GlobalScript._set_fire_rate(value)

func _on_bullet_velocity_value_changed(value):
	GlobalScript._set_bullet_velocity(value)
