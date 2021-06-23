extends KinematicBody2D

signal died

onready var sprite = get_node("sprite")

var alive = true

var walking_left = false
var walking_right = false

const WALK_FORCE = 1200
const WALK_MAX_SPEED = 600
const STOP_FORCE = 2000
const JUMP_SPEED = 900

var velocity = Vector2()

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var walk = WALK_FORCE * (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	
	if alive:
		if abs(walk) < WALK_FORCE * 0.2:
			velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
		else:
			velocity.x += walk * delta
		velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
	else:
		velocity.x = 0
	
	velocity.y += gravity * delta
	
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	
	if is_on_floor() and Input.is_action_just_pressed("jump") and alive:
		jump()
	
	walking_right = false
	walking_left = false
	if walk > 0:
		walking_right = true
	elif walk < 0:
		walking_left = true

func _process(delta):
	if not alive:
		sprite.play('jump')
		return
	
	if (walking_left or walking_right) and is_on_floor():
		sprite.play('walking')
	elif not is_on_floor():
		sprite.play('jump')
	else:
		sprite.play('idle')
	
	if walking_right:
		sprite.set_flip_h(false)
	elif walking_left:
		sprite.set_flip_h(true)
	
	if position.y > 800: die()

func _on_head_body_entered(body):
	if not alive: return
	if body.has_method('destroy'):
		body.destroy()

func _on_body_body_entered(body):
	if not alive: return
	die()

func _on_feet_body_entered(body):
	if not alive: return
	jump()
	body.smash()

func jump():
	velocity.y = -JUMP_SPEED

func die():
	if not alive: return
	alive = false
	get_node("shape").set_deferred("disabled", true)
	jump()
	emit_signal("died")
