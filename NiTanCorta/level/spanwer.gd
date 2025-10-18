extends Node2D

@export_enum("To left", "To right") var spawn_direction: int

@onready var marker_1: Marker2D = $Marker2D
@onready var marker_2: Marker2D = $Marker2D2

@export var scenes_to_spawn: Array[PackedScene]

@export var spawn_interval: float = 1.0 # tiempo entre spawns en segundos
@export var speed: float = 200.0 # velocidad de los objetos

var spawn_timer: float = 0.0

func _ready() -> void:
	print(spawn_direction) # this prints 0 or 1

func _process(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_object()

func spawn_object() -> void:
	var new_instance : Eatable = scenes_to_spawn.pick_random().instantiate()
	
	# Posición aleatoria entre los markers
	var min_x = marker_1.position.x
	var max_x = marker_2.position.x
	var min_y = marker_1.position.y
	var max_y = marker_2.position.y
	
	var spawn_pos = Vector2(
		randf_range(min_x, max_x),
		randf_range(min_y, max_y)
	)
	new_instance.position = spawn_pos

	# Agregar un script sencillo para moverlo
	new_instance.direction = spawn_direction

	add_child(new_instance)
