class_name Plant extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hitbox.Damaged.connect(take_damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_damage(_damage: int) -> void:
	queue_free() # destroy plant
