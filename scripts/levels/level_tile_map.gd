class_name LevelTileMap extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.change_tilemap_bounds(get_tilemap_bounds())


func get_tilemap_bounds() -> Array[Vector2]:
	var min_x = INF
	var min_y = INF
	var max_x = -INF
	var max_y = -INF

	for child in get_children():
		if child is TileMapLayer:
			var used_rect = child.get_used_rect()
			var left = used_rect.position.x * child.rendering_quadrant_size
			var top = used_rect.position.y * child.rendering_quadrant_size
			var right = used_rect.end.x * child.rendering_quadrant_size
			var bottom = used_rect.end.y * child.rendering_quadrant_size
			
			if left < min_x:
				min_x = left
			if top < min_y:
				min_y = top
			if right > max_x:
				max_x = right
			if bottom > max_y:
				max_y = bottom
	
	return [
		Vector2(min_x, min_y),
		Vector2(max_x, max_y)
	]
