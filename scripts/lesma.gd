extends KinematicBody2D

var way = 1

func _process(delta):
	var new_offset = get_parent().get_unit_offset() + delta * way * 0.3
	if way == 1 and new_offset >= 0.9:
		way = -1
		get_parent().set_unit_offset(0.9999)
		get_node("sprite").set_flip_h(false)
	if way == -1 and new_offset <= 0:
		way = 1
		get_parent().set_unit_offset(0)
		get_node("sprite").set_flip_h(true)
	else:
		get_parent().set_unit_offset(new_offset)
