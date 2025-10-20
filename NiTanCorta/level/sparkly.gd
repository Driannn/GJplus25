class_name Eatable
extends Node2D 

signal win_notify()

@export var possible_colors: Array[Color]
@export var speed: float = 100.0 # pixeles por segundo
@export var score_value: int

enum Direction { GO_LEFT, GO_RIGHT }
var direction: Direction = Direction.GO_RIGHT

var my_level: MainLevel

func _ready() -> void:
	$AnimatedSprite2D.self_modulate = possible_colors.pick_random()

func _process(delta: float) -> void:
	if direction == Direction.GO_LEFT:
		position.x -= speed * delta
	elif direction == Direction.GO_RIGHT:
		position.x += speed * delta


func _on_area_entered(_area: Area2D) -> void:
	
	GameManager.score.value += score_value
	if GameManager.score.value < 0:
		GameManager.score.value= 0
	elif GameManager.score.value >= 100:
		win_notify.emit()

	print_debug(GameManager.score.value)
	
	GameManager.audio.eat.play()
	destroy()

func destroy():
	if my_level != null:
		win_notify.disconnect(my_level.on_win_listened)
	queue_free()

func set_level(level: MainLevel):
	my_level = level

func _on_timer_timeout() -> void:
	destroy()
