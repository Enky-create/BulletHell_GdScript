extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("xxxxxx")


func _on_body_entered(body):
	if owner.has_method("take_damage"):
		owner.call_deferred("take_damage",body)
		
