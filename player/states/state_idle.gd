class_name State_Idle extends State

const state_name = "idle"

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"

func enter() -> void:
	character.update_animation(state_name)
	pass


func exit() -> void:
	pass


func process(_delta: float) -> State:
	if character.move_direction != Vector2.ZERO:
		return walk
	
	character.velocity = Vector2.ZERO
	if character.update_face_direction():
		character.update_animation(state_name)
	
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
			return attack
	return null
