extends TileMap
class_name Astar
@onready var astar = AStarGrid2D.new()
@onready var map_rectnagle=Rect2i()
var count:int=0
# Called when the node enters the scene tree for the first time.
func create_astar():
	var tilemap_size = get_used_rect().end - get_used_rect().position
	map_rectnagle =Rect2i(Vector2i.ZERO,tilemap_size)
	astar.region = map_rectnagle
	astar.cell_size = tile_set.tile_size
	astar.default_compute_heuristic=AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic=AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode=AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coords = Vector2i(i,j)
			var tile_data = get_cell_tile_data(0,coords)
			if tile_data and tile_data.get_custom_data("is_walkable")==true:
				print(coords)
			if tile_data and tile_data.get_custom_data("is_walkable")!=true:
				astar.set_point_solid(coords)

func is_point_walkable(position:Vector2)->bool:
	var map_position = local_to_map(position)
	if(map_rectnagle.has_point(map_position) and not astar.is_point_solid(map_position)):
		return true
	return false
