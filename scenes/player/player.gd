class_name Player1
extends CharacterBody2D
@export var shoot_delay:float
@export var _speed = 300.0
@export var _friction:float
var _direction:Vector2
@export var health:float
@onready var spawner = $Spawner
@onready var shoot_timer = $ShootTimer
var can_shoot:bool=true
func _ready():
	shoot_timer.wait_time=shoot_delay
	shoot_timer.timeout.connect(_on_shoot_timer_out)
	
func _physics_process(delta):
	_move_position(delta)
	if(Input.is_action_pressed("main_action")):
		shoot()

func _move_position(delta:float):
	_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if _direction:
		velocity=_direction * _speed
	else:
		velocity=velocity.lerp(Vector2.ZERO,_friction*delta)
	move_and_slide()

func take_damage(damage:float):
	print("AAAAAAAAAAA")
func shoot():
	if(can_shoot):
		spawner.spawn_object()
		can_shoot=false
		shoot_timer.start()
func _on_shoot_timer_out():
	can_shoot=true
