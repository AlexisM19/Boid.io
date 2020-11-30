extends Button

export var reference_path = ""
export(bool) var start_focused = false

func _ready():
	if(start_focused):
		grab_focus()
		
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_DevButton_Pressed")
	$MusicStatus.text = str(GlobalScript.musicOption)

func _on_Button_mouse_entered():
	grab_focus()

func _on_DevButton_Pressed():
	GlobalScript.musicOption = !GlobalScript.musicOption
	$MusicStatus.text = str(GlobalScript.musicOption)
	if !GlobalScript.isInGame:
		$"/root/MenuMusicNode".toggle_music(GlobalScript.musicOption)
	else:
		get_parent().get_parent().get_parent().get_parent().get_parent().get_node("MainRooms").toggle_music()
