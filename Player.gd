extends Entity
class_name Player
@export var _speed = 300.0
@export var _friction:float

func move_with_direction(direction: Vector2):
	
	if direction:
		velocity=direction * _speed
	else:
		velocity=velocity.lerp(Vector2.ZERO,_friction)
	move_and_slide()
	
func attack():
	print("attack")
