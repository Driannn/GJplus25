class_name Eatable
extends Node2D 

@export var possible_colors: Array[Color]
@export var speed: float = 100.0 # pixeles por segundo

enum Direction { GO_LEFT, GO_RIGHT }
var direction: Direction = Direction.GO_RIGHT

func _ready() -> void:
	$AnimatedSprite2D.self_modulate = possible_colors.pick_random()

func _process(delta: float) -> void:
	if direction == Direction.GO_LEFT:
		position.x -= speed * delta
	elif direction == Direction.GO_RIGHT:
		position.x += speed * delta


func _on_area_entered(_area: Area2D) -> void:
	queue_free()
