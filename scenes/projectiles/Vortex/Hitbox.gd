extends Area2D
@export
var damage:float
# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring=false
	collision_mask=1
	collision_layer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
