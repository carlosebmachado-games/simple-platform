extends StaticBody2D

func destroy():
	get_node('shape').queue_free()
	get_node('sprite').queue_free()
	get_node('particles').set_deferred('emitting', true)
