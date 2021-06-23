extends Camera2D

onready var left = get_tree().get_current_scene().get_node('left_limit')
onready var right = get_tree().get_current_scene().get_node('right_limit')

func _ready():
	limit_left = left.position.x
	limit_top = left.position.y
	limit_right = right.position.x
	limit_bottom = right.position.y
