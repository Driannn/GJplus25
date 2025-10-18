extends CharacterBody2D

@export var tongue_anim: AnimationPlayer

## Fix sprite rotation
var rotation_offset_degrees: float = 90.0

func _input(event):
	if (event is InputEventScreenTouch and event.pressed) \
	or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
		look_at_input_pos(event)
		tongue_anim.play("TongueMove")

func look_at_input_pos(event) -> void:
	var input_pos = event.position
	var global_input_pos = get_viewport().get_canvas_transform().affine_inverse() * input_pos

	print("Coordenadas de la pantalla (Viewport): ", input_pos)
	print_debug("Coordenadas globales (Mundo): ", global_input_pos)

	look_at(global_input_pos)
	rotation += deg_to_rad(rotation_offset_degrees)
