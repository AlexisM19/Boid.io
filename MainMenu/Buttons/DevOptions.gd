extends Button

export var reference_path = ""
export(bool) var start_focused = false

func _ready():
	if(start_focused):
		grab_focus()
		
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_DevButton_Pressed")
	$DevStatus.text = str(GlobalScript.devOptions)

func _on_Button_mouse_entered():
	grab_focus()

var status = false
func _on_DevButton_Pressed():
	$DevStatus.text = str(!status)
	status = !status
	GlobalScript.devOptions = status
