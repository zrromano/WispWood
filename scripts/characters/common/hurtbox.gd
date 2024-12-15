class_name Hurtbox extends Area2D


@export var damage: int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _area_entered(a: Area2D) -> void:
	if a is HitBox:
		a.take_damage(damage)


func deal_damage(damage: int) -> void:
	pass
