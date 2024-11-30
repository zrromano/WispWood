class_name State_Attack extends State

const state_name = "attack"

@export var move_speed: float = 100.0

@onready var idle: State = $"../Idle"

func enter() -> void:
	character.update_animation(state_name)
	pass


func exit() -> void:
	pass


func process(_delta: float) -> State:
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	return null
