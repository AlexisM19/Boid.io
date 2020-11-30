extends CanvasLayer

signal change_camera

func _ready():
	if GlobalScript.devOptions:
		$LogDev.visible = true
		$CheckBox.visible = true
		$Label.visible = true
	else:
		$LogDev.visible = false
		$CheckBox.visible = false
		$Label.visible = false


func _on_CheckBox_toggled(button_pressed):
	emit_signal("change_camera", button_pressed)
