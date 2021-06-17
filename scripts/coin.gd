extends Area2D

func _on_coin_body_entered(body):
	get_node("shape").queue_free()
	get_node("anim").play("collect")
	yield(get_node("anim"), "animation_finished")
	queue_free()
