extends Area2D

signal on_movement_request(go_to_position)

# Called whe tongue hits paint on floor
func movement_request(go_to_position):
	on_movement_request.emit(go_to_position)
