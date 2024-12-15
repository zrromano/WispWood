class_name PlayerCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.TileMapBoundsChanged.connect(update_limits)
	update_limits(LevelManager.current_tilemap_bounds) # redundancy


func update_limits(bounds: Array[Vector2]) -> void:
	if bounds == []:
		return
	
	# bounds[0] = top left corner
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	# bounds[1] = bottom right corner
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
