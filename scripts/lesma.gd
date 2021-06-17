extends KinematicBody2D

var way = 1

func _process(delta):
	var new_offset = get_parent().get_unit_offset() + delta * way * 0.3
	
