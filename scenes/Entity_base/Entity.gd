extends CharacterBody2D
class_name Entity
@onready var collision_shape_2d = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

func move_with_direction(direction: Vector2):
	pass
func attack():
	pass
