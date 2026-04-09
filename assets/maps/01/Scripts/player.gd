extends CharacterBody2D


const playerSpeed = 100.0

var move_input : Vector2

func _physics_process (delta: float) -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * playerSpeed
	move_and_slide()
