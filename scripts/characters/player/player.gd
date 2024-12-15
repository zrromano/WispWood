class_name Player extends Character


var pressed_face_direction: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_move_direction()


func _physics_process(delta: float) -> void:
	move_and_slide()


func _input(event: InputEvent) -> void:
	pressed_face_direction = FaceUtils.get_face_direction_from_event(event)


func update_move_direction() -> void:
	var horizontal: float = Input.get_axis("move_left", "move_right")
	var vertical: float = Input.get_axis("move_up", "move_down")
	
	if horizontal == 0:
		# Swap directions if the opposite direction was just pressed
		if (Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")):
			horizontal = -move_direction.x
		# Keep moving if both directions remain held
		elif Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
			horizontal = move_direction.x
	
	if vertical == 0:
		# Swap directions if the opposite direction was just pressed
		if (Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down")):
			vertical = -move_direction.y
		# Keep moving if both directions remain held
		elif Input.is_action_pressed("move_up") and Input.is_action_pressed("move_down"):
			vertical = move_direction.y
	
	move_direction = Vector2(
		horizontal,
		vertical
		
	).normalized()


func get_face_direction() -> Vector2:
	if pressed_face_direction != Vector2.ZERO and FaceUtils.is_face_direction_pressed():
			# Use pressed direction if any face directions are pressed
			return pressed_face_direction
	else:
		pressed_face_direction = Vector2.ZERO
		return super.get_face_direction()
