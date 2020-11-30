extends Node

func _ready():
	if(GlobalScript.speed_value):
		$SlidersAndMore/HBoxContainer/VBoxContainer/MoveSpeed/HSlider.value = ( GlobalScript.speed_value * 100) / 800
	if(GlobalScript.ennemies_value):
		$SlidersAndMore/HBoxContainer/VBoxContainer/EnnemiesCount/HSlider.value = (GlobalScript.ennemies_value * 100) / 12
	if(GlobalScript.food_value):
#		$Sliders/VBoxContainer/FoodCount/HSlider.value = (GlobalScript.food_value * 100) / 30
		pass






func _on_Rooms_Count_value_changed(value):
	GlobalScript.rooms_count = value


func _on_Rooms_Min_Size_value_changed(value):
	GlobalScript.rooms_min_size = int(value)


func _on_Rooms_Max_Size_value_changed(value):
	GlobalScript.rooms_max_size = int(value)


func _on_Rooms_H_Spread_value_changed(value):
	GlobalScript.rooms_h_spread = int(value)


func _on_Rooms_V_Spread_value_changed(value):
	GlobalScript.rooms_v_spread = int(value)
