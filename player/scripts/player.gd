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
	move_direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()


func get_face_direction() -> Vector2:
	if pressed_face_direction != Vector2.ZERO and FaceUtils.is_face_direction_pressed():
			# Use pressed direction if any face directions are pressed
			return pressed_face_direction
	else:
		pressed_face_direction = Vector2.ZERO
		return super.get_face_direction()
