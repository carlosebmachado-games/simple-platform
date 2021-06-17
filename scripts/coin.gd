extends Area2D

func _ready():
	pass

func _process(delta):
	pass


func _on_coin_area_entered(area):
	get_node("shape").queue_free()
	get_node("anim").play("collect")
