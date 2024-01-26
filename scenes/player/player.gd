extends CharacterBody2D

@export
var _speed = 300.0
@export
var _friction:float
var _direction:Vector2
@export
var health:float
func _physics_process(delta):
	_move_position(delta)

func _move_position(delta:float):
	_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if _direction:
		velocity=_direction * _speed
	else:
		velocity=velocity.lerp(Vector2.ZERO,_friction*delta)
	move_and_slide()
	
func take_damage(damage:Node2D):
	
	print("i took damage ")
