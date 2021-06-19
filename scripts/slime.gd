extends KinematicBody2D

var alive = true
var way = 1

onready var sprite = get_node("sprite")

func _process(delta):
	var new_offset = get_parent().get_unit_offset() + delta * way * 0.3
	if way == 1 and new_offset >= 0.9:
		way = -1
		get_parent().set_unit_offset(0.9999)
		sprite.set_flip_h(false)
	if way == -1 and new_offset <= 0:
		way = 1
		get_parent().set_unit_offset(0)
		sprite.set_flip_h(true)
	else:
		get_parent().set_unit_offset(new_offset)

func smash():
	if not alive: return
	alive = false
	sprite.set_animation("dead")
	sprite.set_offset(Vector2(0, 8))
	get_node("shape").queue_free()
	set_process(false)
