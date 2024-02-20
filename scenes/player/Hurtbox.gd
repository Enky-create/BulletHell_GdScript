class_name Hurtbox
extends Area2D

func _ready():
	self.area_entered.connect(_on_hitbox_entered)
	Spawning.bullet_collided_body.connect(_on_bullet_collided_body)

func _on_bullet_collided_body(body:Node, body_shape_index:int, bullet: Dictionary, local_shape:int,shared_area:Area2D):
	if body == owner and body.has_method("take_damage"):
		body.take_damage(bullet["props"]["damage"])

func _on_hitbox_entered(body:HitBox):
	if owner.has_method("take_damage"):
		owner.take_damage(body.damage)
