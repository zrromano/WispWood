class_name PlayerInteractionsHost extends Node2D


@onready var player: Player = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.DirectionChanged.connect(update_direction)


func update_direction(new_direction: Vector2) -> void:
	match new_direction:
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.UP:
			rotation_degrees = 180
		Vector2.RIGHT:
			rotation_degrees = 270
		_:
			rotation_degrees = 0
	pass
