extends KinematicBody2D

var way = 1

onready var sprite = get_node("sprite")

func _process(delta):
	var new_offset = get_parent().get_unit_offset() + delta * way * 0.1
	if way == 1 and new_offset >= 0.9:
		way = -1
		get_parent().set_unit_offset(0.9999)
	if way == -1 and new_offset <= 0:
		way = 1
		get_parent().set_unit_offset(0)
	else:
		get_parent().set_unit_offset(new_offset)
