extends Spawner
@export var target_layer:int
func set_object()->Node2D:
	var projectile_instance:Projectile = object.instantiate() as Projectile
	projectile_instance.layer=target_layer
	return projectile_instance
