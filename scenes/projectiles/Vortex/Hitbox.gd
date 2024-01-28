class_name HitBox
extends Area2D
@export
var damage:float
@onready var collision_shape = $CollisionShape2D
func _init():
	monitoring=false
	collision_mask=0
	collision_layer = 2

func set_disabled(is_disabled:bool):
	collision_shape.set_deffered("disabled",is_disabled)
