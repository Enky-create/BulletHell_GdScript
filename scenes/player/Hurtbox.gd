class_name Hurtbox
extends Area2D

func _ready():
	self.area_entered.connect(_on_hitbox_entered)

func _on_hitbox_entered(body:HitBox):
	if owner.has_method("take_damage"):
		owner.take_damage(body.damage)
