extends Node

func _ready():
	if(GlobalScript.speed_value):
		$Sliders/VBoxContainer/MoveSpeed/HSlider.value = ( GlobalScript.speed_value * 100) / 800
	if(GlobalScript.ennemies_value):
		$Sliders/VBoxContainer/EnnemiesCount/HSlider.value = (GlobalScript.ennemies_value * 100) / 12
	if(GlobalScript.food_value):
#		$Sliders/VBoxContainer/FoodCount/HSlider.value = (GlobalScript.food_value * 100) / 30
		pass
