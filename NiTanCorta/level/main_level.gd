class_name MainLevel
extends Node

@onready var win_panel: Panel = $UI/WinPanel

@onready var timer: Timer = $Timer
@onready var label: Label = $UI/Label
@onready var lose_panel: Panel = $UI/LosePanel

var is_win: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !timer.is_stopped():
		var time = ceil(timer.time_left)
		time = str(time)
		label.text = time
	
	if timer.is_stopped():
		label.text = "0"
		if !is_win:
			lose_panel.visible = true
			Engine.time_scale = 0


func on_win_listened():
	is_win = true
	win_panel.visible = true
	Engine.time_scale = 0


func _on_button_pressed() -> void:
	GameManager.score.value = 0
	get_tree().reload_current_scene()
