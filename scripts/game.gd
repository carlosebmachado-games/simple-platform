extends Node2D

onready var player = get_node("player")
onready var camera = get_node("death_camera")

func change_camera():
	camera.set_global_position(player.get_node("camera").get_camera_position())
	camera.make_current()

func _on_player_died():
	change_camera()
