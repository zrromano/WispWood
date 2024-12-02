class_name PlayerState_Attack extends State

const state_name = "attack"

var attack_direction: Vector2
var next_direction: Vector2
var player: Player
var attacking: bool = false
var queue_attack: bool = false

@export var move_speed: float = 100.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack: State = $"../Attack"
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"

func enter() -> void:   
	player = character
	
	if queue_attack:
		attack_direction = next_direction
	else: 
		attack_direction = FaceUtils.get_most_recent_face_direction()
	player.update_face_direction()
	
	next_direction = Vector2.ZERO
	attacking = true
	queue_attack = false
	
	player.update_animation(state_name)
	animation_player.animation_finished.connect(end_attack)


func exit() -> void:
	pass


func process(_delta: float) -> State:
	player.velocity = player.move_direction * move_speed
	
	if attacking == false:
		if queue_attack and FaceUtils.is_face_direction_pressed():
				enter() # Attack again
		elif player.move_direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(event: InputEvent) -> State:
	var input_direction: Vector2 =  FaceUtils.get_face_direction_from_event(event)
	if  input_direction != Vector2.ZERO && input_direction != attack_direction:
			next_direction = input_direction
			queue_attack = true
	return null


func get_face_direction() -> Vector2:
	return attack_direction


func end_attack(next_animation: String) -> void:
	attacking = false
