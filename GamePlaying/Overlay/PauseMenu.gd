extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused 
		get_tree().paused = new_pause_state
		visible = new_pause_state

func _ready():
	if !GlobalScript.devOptions:
		$PauseOverlay/ColorRect.visible = false
		$PauseOverlay/ColorRect2.visible = false
	visible = false
	$ControlsBackground.visible = false
	$ControlsView.visible = false

func show_controls():
	$ControlsBackground.visible = !$ControlsBackground.visible
	#$ControlsBackground/ColorRect.visible = false
	$PauseOverlay.visible = !$PauseOverlay.visible
	$ControlsView.visible = !$ControlsView.visible
