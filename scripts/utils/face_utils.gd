class_name FaceUtils extends Node


static func get_face_direction_from_event(event: InputEvent) -> Vector2:
	if event.is_action_pressed("face_up"):
		return Vector2.UP
	elif event.is_action_pressed("face_down"):
		return Vector2.DOWN
	elif event.is_action_pressed("face_left"):
		return Vector2.LEFT
	elif event.is_action_pressed("face_right"):
		return Vector2.RIGHT
	else:
		return Vector2.ZERO


static func get_most_recent_face_direction() -> Vector2:
	var most_recent_time: int = -1
	var most_recent_action: String
	var action_times: Dictionary = InputManager.action_times
	for action in action_times.keys():
		var time = action_times[action]
		if action.begins_with("face_") and time > most_recent_time:
			most_recent_time = time
			most_recent_action = action
	
	if most_recent_action == "face_up":
		return Vector2.UP
	elif most_recent_action == "face_down":
		return Vector2.DOWN
	elif most_recent_action == "face_left":
		return Vector2.LEFT
	else:
		return Vector2.RIGHT

static func get_pressed_face_direction() -> Vector2:
	if is_face_direction_pressed():
		return get_most_recent_face_direction()
	else:
		return Vector2.ZERO 


static func is_face_direction_pressed() -> bool:
	return Input.is_action_pressed("face_up") or \
		   Input.is_action_pressed("face_down") or \
		   Input.is_action_pressed("face_left") or \
		   Input.is_action_pressed("face_right")
