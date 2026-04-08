extends CharacterBody2D
@export var playerSpeed = 100.0
var move_input : Vector2

func _physics_process (_delta):
	move_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_input * playerSpeed
	move_and_slide()
