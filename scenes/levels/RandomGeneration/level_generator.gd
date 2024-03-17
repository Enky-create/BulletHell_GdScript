extends Node2D
const DIRECTIONS:Array=[Vector2.RIGHT,Vector2.LEFT, Vector2.UP, Vector2.DOWN]

@export var Deathbringer:PackedScene
@export var WIDTH:int = 70
@export var HEIGHT:int = 38
@export var room_min_size:int
@export var room_max_size:int
@export var hallway_max_length:int
@export var steps:int=500
@export var player_scene:PackedScene
@export var exit:PackedScene
var player:EntityController
var borders = Rect2(1,1,WIDTH,HEIGHT)
@onready var tile_map:Astar = %TileMap
var tile_size
var map

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_size=tile_map.tile_set.tile_size
	randomize()
	generate_level()
	tile_map.create_astar()
	_test_enemy()

func generate_level():
	var walker = Walker.new(Vector2(WIDTH/2, HEIGHT/2),borders, room_min_size, room_max_size, hallway_max_length)
	map= walker.walk(steps)
	var exit:ExitDoor = exit.instantiate()
	add_child(exit)
	exit.position=walker.get_end_room().room_position*tile_size.x
	exit.leaving_level.connect(reload_level)
	walker.queue_free()
	var walls=[]
	
	for y in range(1, HEIGHT - 1):
		for x in range(1, WIDTH - 1):
			var tile_position = Vector2(x, y)
			if map.find(tile_position) == -1:  # Если тайл не в комнате
				if has_adjacent_room(tile_position, map):
					tile_map.set_cell(0, tile_position, 1)  # Устанавливаем тайл стены
					walls.append(tile_position)
	tile_map.set_cells_terrain_connect(0, walls, 0, 1)
	for location in map:
		tile_map.set_cell(0,location,0)
	tile_map.set_cells_terrain_connect(0, map, 0, 0)
	player = player_scene.instantiate()
	add_child(player)
	
	player.position = map[0] * tile_size.x

func reload_level():
	# Устанавливаем таймер для перезагрузки сцены через небольшую задержку
	var reload_timer = Timer.new()
	reload_timer.one_shot = true
	reload_timer.wait_time = 0.1 # Небольшая задержка в секундах
	add_child(reload_timer)
	reload_timer.start()
	reload_timer.timeout.connect(_on_reload_timer_timeout)

func _on_reload_timer_timeout():
	# Перезагружаем текущую сцену
	get_tree().reload_current_scene()

func has_adjacent_room(tile_position: Vector2, map: Array) -> bool:
	for direction in DIRECTIONS:
		var neighbor_tile = tile_position + direction
		if map.find(neighbor_tile) != -1:  # Если соседний тайл находится в комнате
			return true
	return false
func _test_enemy():
	var enemy = Deathbringer.instantiate()
	enemy.astar=tile_map
	enemy.target=player.entity
	enemy.position=map[1] * tile_size.x
	add_child(enemy)
