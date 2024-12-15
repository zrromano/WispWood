class_name PlayerState_Walk extends State

const state_name = "walk"

var player: Player = character

@export var move_speed: float = 100.0

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"

func enter() -> void:
	player = character
	
	player.update_animation(state_name)


func exit() -> void:
	pass


func process(_delta: float) -> State:
	if player.move_direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.move_direction * move_speed
	
	if player.update_face_direction():
		player.update_animation(state_name)
	
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(event: InputEvent) -> State:
	if FaceUtils.get_face_direction_from_event(event) != Vector2.ZERO:
			return attack
	return null
