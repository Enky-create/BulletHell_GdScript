extends Node
class_name Walker

const DIRECTIONS:Array=[Vector2.RIGHT,Vector2.LEFT, Vector2.UP, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history:Array=[]
var rooms:Array=[]
var steps_since_turn = 0
var room_min_size:int
var room_max_size:int
var hallway_max_length:int

func _init(starting_position:Vector2, new_borders:Rect2, room_min_size, room_max_size, hallway_length):
	assert(new_borders.has_point(starting_position))
	hallway_max_length=hallway_length
	self.room_max_size = room_max_size
	self.room_min_size = room_min_size
	position=starting_position
	step_history.append(position)
	borders=new_borders

func walk(steps:int)->PackedVector2Array:
	place_room(position)
	for step in steps:
		if(steps_since_turn>=hallway_max_length):
			change_direction()
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

func step()->bool:
	var target_position = direction + position
	if(borders.has_point(target_position)):
		position=target_position
		steps_since_turn+=1
		step_history.append(position)
		return true
	return false
func change_direction():
	place_room(position)
	steps_since_turn=0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction=directions.pop_front()
	while(not borders.has_point(direction+position)):
		direction=directions.pop_front()
func place_room(position):
	var size = Vector2(randi()%room_max_size +room_min_size, randi()%room_max_size +room_min_size)
	var top_left_corner = (position - size/2).ceil()
	rooms.append(create_room(position, size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x,y)
			if borders.has_point(new_step):
				step_history.append(new_step)
				
func create_room(position,size)->Dictionary:
	return {room_position=position, room_size= size}
	
func get_end_room()->Dictionary:
	var starting_position:Vector2 = step_history[0]
	var end_room=rooms.pop_front()
	for room in rooms:
		if starting_position.distance_to(room.room_position)>starting_position.distance_to(end_room.room_position):
			end_room=room
	return end_room
	
