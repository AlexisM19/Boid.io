extends Position2D

signal shot
signal camera_shake_requested
signal frame_freeze_requested

onready var timer : Timer = $Timer
onready var spawn_position : Position2D = $ShootPosition
#onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer
#onready var animation_player : AnimationPlayer = $AnimationPlayer

export var fire_rate : = 5 setget set_fire_rate
export var bullet : PackedScene


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if GlobalScript.fire_rate != 0:
		timer.wait_time = 1.0 / GlobalScript.fire_rate
	if Input.is_action_pressed("shoot") and timer.is_stopped():
		shoot()


func _on_Bullet_destroyed(enemy_hit: bool) -> void:
	if GlobalScript.sfxOption:
		$Colliding.play()
	if enemy_hit:
		emit_signal("camera_shake_requested")
		emit_signal("frame_freeze_requested")


func shoot() -> void:
	timer.start()
	emit_signal("shot")
	if GlobalScript.sfxOption:
		$Shooting.play()
	var new_bullet = bullet.instance()
	new_bullet.initialize((get_global_mouse_position() - global_position).normalized())
	add_child(new_bullet)
	new_bullet.global_position = spawn_position.global_position
	new_bullet.look_at(get_global_mouse_position())
	new_bullet.connect("destroyed", self, "_on_Bullet_destroyed")

func set_fire_rate(value: int) -> void:
	fire_rate = value
	timer.wait_time = 1.0 / GlobalScript.fire_rate
