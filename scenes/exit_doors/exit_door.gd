extends Area2D
class_name ExitDoor
signal leaving_level

func _on_body_entered(body):
	leaving_level.emit()
	queue_free()
