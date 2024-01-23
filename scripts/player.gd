extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export
var _friction:float

func _physics_process(delta):
	var direction:Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction:
		velocity=direction.normalized() * SPEED
	else:
		velocity=velocity.lerp(Vector2.ZERO,_friction*delta)
	move_and_slide()
