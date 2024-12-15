class_name PlayerState_Attack extends State

const state_name = "attack"

var attack_direction: Vector2
var next_direction: Vector2
var player: Player
var attacking: bool = false
var queue_attack: bool = false

@export var move_speed: float = 100.0
@export var attack_sound: AudioStream
@export var input_threshold: float = 0.5
@export var hurt_delay: float = 0.075

@onready var animation_player: AnimationPlayer = $"../../PlayerSprite/AnimationPlayer"
@onready var attack_animation_player: AnimationPlayer = $"../../PlayerSprite/SwordSwoosh/AnimationPlayer"
@onready var audio_player: AudioStreamPlayer2D = $"../../Audio/AudioPlayer"
@onready var hurtbox: Hurtbox = $"../../Interactions/AttackHurtbox"

@onready var attack: State = $"."
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"

func enter() -> void:   
	player = character
	
	if queue_attack:
		attack_direction = next_direction
	else: 
		attack_direction = FaceUtils.get_most_recent_face_direction()
	player.update_face_direction()
	
	audio_player.stream = attack_sound
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	
	player.update_animation(state_name)
	attack_animation_player.play(state_name + "_" + player.get_animation_direction())
	audio_player.play()
	
	animation_player.animation_finished.connect(end_attack)
	
	next_direction = Vector2.ZERO
	attacking = true
	queue_attack = false
	
	await get_tree().create_timer(hurt_delay).timeout
	hurtbox.monitoring = true


func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)


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
	if can_accept_input():
		var input_direction: Vector2 =  FaceUtils.get_face_direction_from_event(event)
		if  input_direction != Vector2.ZERO:
				next_direction = input_direction
				queue_attack = true
	return null


func get_face_direction() -> Vector2:
	return attack_direction


func end_attack(next_animation: String) -> void:
	attacking = false
	hurtbox.monitoring = false


func can_accept_input() -> bool:
	if attack_animation_player.is_playing():
		var position = attack_animation_player.current_animation_position
		var length = attack_animation_player.current_animation_length
		var progress = position / length
		return progress >= input_threshold
	else:
		return false
