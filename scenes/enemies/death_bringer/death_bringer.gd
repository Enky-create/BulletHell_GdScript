extends Entity
class_name DeathBringer
var astar:Astar
@onready var state_chart = $StateChart
@export var max_health:float=100
var health:float=max_health
var current_path=[]
@export var speed:int
@export var attack_distance:int
var target:Entity
@onready var detection_area_2d = $DetectionArea2D
@onready var search_timer = $SearchTimer
@onready var attack_delay = $AttackDelay
var start
var end
func _on_detection_area_2d_body_entered(body):
	if body.is_in_group("player") and body is Entity:
		target=body
		state_chart.send_event("walk")

func take_damage(damage:float):
	health-=damage
	state_chart.send_event("hurt")
	if health<=0:
		state_chart.send_event("death")
	if health/max_health < 0.5:
		state_chart.send_event("half_health")
	if health/max_health < 0.15:
		state_chart.send_event("last_breath")

func _on_idle_state_entered():
	animation_player.play("idle")


func _on_search_timer_timeout():
	if astar and astar.is_point_walkable(target.global_position):
		start=astar.local_to_map(global_position)
		end = astar.local_to_map(target.global_position)
		current_path = astar.astar.get_id_path(start,end)


func _on_walk_state_entered():
	animation_player.play("walk")
	


func _on_walk_state_physics_processing(_delta):
	if(current_path.is_empty()):
		return
	var path_point = astar.map_to_local(current_path.pop_front())
	global_position=global_position.move_toward(path_point,speed)
	#if(global_position.distance_to(path_point)<attack_distance):
		#state_chart.send_event("attack")
