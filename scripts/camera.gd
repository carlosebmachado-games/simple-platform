extends Camera2D

onready var left = get_node('left')
onready var right = get_node('right')

func _ready():
	limit_left = left.position.x
	limit_top = left.position.y
	limit_right = right.position.x
	limit_bottom = right.position.y
