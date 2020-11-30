extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if !GlobalScript.devOptions:
		visible = false
	else:
		if(GlobalScript.fire_rate):
			$HBoxContainer/VBoxContainer/FireRate/HSlider.value = ( GlobalScript.fire_rate * 100) / 30
		if(GlobalScript.bullet_velocity):
			$HBoxContainer/VBoxContainer/BulletVel/HSlider.value = ( GlobalScript.bullet_velocity * 100) / 500
		if GlobalScript.rooms_count:
			$"HBoxContainer/VBoxContainer2/RoomsCount/Rooms Count".value = GlobalScript.rooms_count
		if GlobalScript.rooms_min_size:
			$"HBoxContainer/VBoxContainer2/RoomsMinSize/Rooms Min Size".value = GlobalScript.rooms_min_size
		if GlobalScript.rooms_max_size:
			$"HBoxContainer/VBoxContainer2/RoomsMaxSize/Rooms Max Size".value = GlobalScript.rooms_max_size
		if GlobalScript.rooms_h_spread:
			$"HBoxContainer/VBoxContainer2/RoomsHSpread/Rooms H Spread".value = GlobalScript.rooms_h_spread
		if GlobalScript.rooms_v_spread:
			$"HBoxContainer/VBoxContainer2/RoomsVSpread/Rooms V Spread".value = GlobalScript.rooms_v_spread
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
