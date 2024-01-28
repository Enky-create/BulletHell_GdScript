class_name Spawner
extends Node2D
@export var object:PackedScene 
var positions:Array[Node]

func _ready():
	positions = $Positions.get_children()

func spawn_object():
	for pos in positions:
		var obj =  object.instantiate()
		obj.position = pos.global_position
		obj.direction = global_position.direction_to(pos.global_position)
		pos.add_child(obj)
