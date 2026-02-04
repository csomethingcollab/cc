extends Node

var X
var Y
var JUMP
var SPECIAL

var logger

func _ready() -> void:
	logger = load("res://src/utils/logger.gd").new("Controls")

func _process(_delta: float) -> void:
	X = Input.get_axis("move_left", "move_right")
	Y = Input.get_axis("move_up", "move_down")
	JUMP = Input.is_action_pressed("jump")
	SPECIAL = Input.is_action_pressed("special")

	# logger.info(var_to_str(JUMP))
