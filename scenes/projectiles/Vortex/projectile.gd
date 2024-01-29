class_name Projectile
extends Node2D
var layer:int=0
@export var speed:float = 500.0
@export var lifetime:float = 2.0

var direction:Vector2 = Vector2.ZERO

@onready var timer = $Timer
@onready var impact_detector = $ImpactDetector
@onready var hitbox = $Hitbox
@onready var sprite = $AnimatedSprite2D

func _ready():
	top_level=true
	look_at(position+direction)
	timer.timeout.connect(queue_free)
	timer.start(lifetime)
	impact_detector.body_entered.connect(_on_impact)
	hitbox.collision_layer=layer
	
func _physics_process(delta):
	position+=direction*speed*delta

func _on_impact(_body:Node2D):
	queue_free()
