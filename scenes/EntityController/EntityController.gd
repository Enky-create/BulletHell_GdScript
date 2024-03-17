extends Node2D
class_name  EntityController
@export var entity:Entity
# Called when the node enters the scene tree for the first time.
func _ready():
	entity=$Entity
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	entity.move_with_direction(direction)
