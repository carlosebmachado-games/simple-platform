extends Node2D

onready var player = get_node("player")
onready var camera = get_node("death_camera")
onready var spawn_timer = get_node('spawn_timer')
onready var game_time = get_node('game_time')

var coins = 0
var lifes = 3

func _process(delta):
	get_node('canvas/pane/lbl_time').set_text(str(int(game_time.get_time_left())))

func change_camera():
	camera.set_global_position(player.get_node("camera").get_camera_position())
	camera.make_current()

func _on_player_died():
	change_camera()
	spawn_timer.set_wait_time(2)
	spawn_timer.start()
	lifes -= 1
	if lifes == 2:
		get_node('canvas/pane/hearth3').set_texture(load('res://assets/hud_heart_empty.png'))
	elif lifes == 1:
		get_node('canvas/pane/hearth2').set_texture(load('res://assets/hud_heart_empty.png'))
	elif lifes == 0:
		get_node('canvas/pane/hearth1').set_texture(load('res://assets/hud_heart_empty.png'))

func _on_spawn_timer_timeout():
	if lifes > 0:
		revive()
	else:
		Transition.fade_to('res://scenes/main_menu.tscn')

func revive():
	player.set_position(get_node('spawn_point').get_position())
	player.revive()
	game_time.set_wait_time(120)
	game_time.start()

func _on_player_end():
	change_camera()
	spawn_timer.set_wait_time(2)
	spawn_timer.start()

func _on_player_coin():
	coins += 1
	get_node('canvas/pane/lbl_coin').set_text(str(coins))

func _on_change_scene_body_entered(body):
	Transition.fade_to('res://scenes/main_menu.tscn')
