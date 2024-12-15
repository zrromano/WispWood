class_name PlayerState_Idle extends State

const state_name = "idle"

var player: Player

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"

func enter() -> void:
	player = character
	character.update_animation(state_name)
	pass


func exit() -> void:
	pass


func process(_delta: float) -> State:
	if player.move_direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	if player.update_face_direction():
		player.update_animation(state_name)
	
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(event: InputEvent) -> State:
	if FaceUtils.get_face_direction_from_event(event) != Vector2.ZERO:
			return attack
	return null
