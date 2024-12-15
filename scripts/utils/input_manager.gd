extends Node


var action_times = {
	"face_up": -1,
	"face_down": -1,
	"face_left": -1,
	"face_right": -1
}


func _ready():
	set_process_input(true)  # Enable input processing for this node


func _input(event: InputEvent) -> void:
	for action in action_times.keys():
		if Input.is_action_pressed(action):
			action_times[action] = Time.get_ticks_msec()
