extends CharacterBody2D

@export var tongue_anim: AnimationPlayer
@export var rotation_speed: float = 8.0 # ajusta para hacerlo más o menos suave


#region Rotation variables
## Fix sprite rotation
var rotation_offset_degrees: float = 90.0
var target_pos: Vector2 = Vector2.ZERO
var rotating: bool = false
#endregion

func _input(event):
	if (event is InputEventScreenTouch and event.pressed) \
	or (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
		look_at_input_pos(event)
		tongue_anim.play("TongueMove")
		GameManager.audio.tongue.play()
		GameManager.audio.eat_good.play()

func look_at_input_pos(event) -> void:
	var input_pos = event.position
	target_pos = get_viewport().get_canvas_transform().affine_inverse() * input_pos
	rotating = true

func _process(delta):
	if rotating:
		var target_angle = (target_pos - global_position).angle()
		var desired_rotation = target_angle + deg_to_rad(rotation_offset_degrees)
		rotation = lerp_angle(rotation, desired_rotation, delta * rotation_speed)

		# detener rotación cuando esté suficientemente cerca
		if abs(angle_difference(rotation, desired_rotation)) < 0.01:
			rotation = desired_rotation
			rotating = false
