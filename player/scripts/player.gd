class_name Player extends CharacterBody2D

var pressed_face_direction: Vector2 = Vector2.ZERO
var face_direction: Vector2 = Vector2.DOWN
var move_direction: Vector2 = Vector2.ZERO
var move_speed: float = 100.0
var state: String = "idle"


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_velocity()
	
	var state_changed: bool = update_state()
	var face_direction_changed: bool = update_face_direction()
	
	if state_changed || face_direction_changed:
		update_animation()
	
	pass


func _physics_process(delta: float) -> void:
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("face_down"):
		pressed_face_direction = Vector2.DOWN
	elif event.is_action_pressed("face_up"):
		pressed_face_direction = Vector2.UP
	elif event.is_action_pressed("face_left"):
		pressed_face_direction = Vector2.LEFT
	elif event.is_action_pressed("face_right"):
		pressed_face_direction = Vector2.RIGHT


func update_velocity() -> void:
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction = move_direction.normalized()
	
	velocity = move_direction * move_speed


func update_face_direction() -> bool:
	var new_direction: Vector2 = face_direction
	
	if pressed_face_direction != Vector2.ZERO and (
		Input.is_action_pressed("face_up") or
		Input.is_action_pressed("face_down") or
		Input.is_action_pressed("face_left") or
		Input.is_action_pressed("face_right")):
			# Use pressed direction if any face directions are pressed
			new_direction = pressed_face_direction
	else:
		# Otherwise, use movement to determine face direction
		pressed_face_direction = Vector2.ZERO
		
		if move_direction == Vector2.ZERO:
			return false  # No movement
		
		if move_direction.y == 0:  # Horizontal movement
			new_direction = Vector2.LEFT if move_direction.x < 0 else Vector2.RIGHT
		elif move_direction.x == 0:  # Vertical movement
			new_direction = Vector2.UP if move_direction.y < 0 else Vector2.DOWN
	
	if new_direction == face_direction:
		return false # No change in direction
	
	face_direction = new_direction
	
	if face_direction == Vector2.LEFT:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
	
	return true


func update_state() -> bool:
	var new_state: String = "idle"
	
	if move_direction != Vector2.ZERO:
		new_state = "walk"
	
	if new_state == state:
		return false
	else:
		state = new_state
		return true


func update_animation() -> void:
	animation_player.play(state + "_" + get_anim_direction())
	pass


func get_anim_direction() -> String:
	match face_direction:
		Vector2.DOWN:
			return "down"
		Vector2.UP:
			return "up"
		_:
			return "side"
