extends CharacterBody2D

@onready var ani: AnimatedSprite2D = $AnimatedSprite2D

var lastFacing = "down"
var state = "standing"

var last_diagonal := Vector2.ZERO
var diagonal_release_timer := 0.0
var diagonal_grace := 0.1

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if direction.x != 0 and direction.y != 0:
		last_diagonal = direction
		diagonal_release_timer = 0.0

	elif last_diagonal != Vector2.ZERO and direction != Vector2.ZERO:
		diagonal_release_timer += delta

		if diagonal_release_timer < diagonal_grace:
			direction = last_diagonal
		else:
			last_diagonal = Vector2.ZERO
	# --------------------------------

	if direction != Vector2.ZERO:
		velocity = direction * 800.0
		if direction == Vector2(0.0, 1.0):
			ani.flip_h = false
			ani.play("Walk")
			lastFacing = "down"
		elif direction == Vector2(0.0, -1.0):
			ani.flip_h = false
			ani.play("WalkUp")
			lastFacing = "up"
		elif direction == Vector2(-1.0, 0.0):
			ani.flip_h = false
			ani.play("WalkLeft")
			lastFacing = "left"
		elif direction == Vector2(1.0, 0.0):
			ani.flip_h = true
			ani.play("WalkLeft")
			lastFacing = "right"
		elif direction.is_equal_approx(Vector2(0.707107, -0.707107)):
			ani.flip_h = true
			ani.play("WalkLeftUp")
			lastFacing = "upRight"
		elif direction.is_equal_approx(Vector2(0.707107, 0.707107)):
			ani.flip_h = true
			ani.play("WalkLeftDown")
			lastFacing = "downRight"
		elif direction.is_equal_approx(Vector2(-0.707107, -0.707107)):
			ani.flip_h = false
			ani.play("WalkLeftUp")
			lastFacing = "upLeft"
		elif direction.is_equal_approx(Vector2(-0.707107, 0.707107)):
			ani.flip_h = false
			ani.play("WalkLeftDown")
			lastFacing = "downLeft"

	else:
		velocity = Vector2.ZERO

		if lastFacing == "down":
			ani.flip_h = false
			ani.play("Idle")
		elif lastFacing == "up":
			ani.flip_h = false
			ani.play("IdleUp")
		elif lastFacing == "left":
			ani.flip_h = false
			ani.play("IdleLeft")
		elif lastFacing == "right":
			ani.flip_h = true
			ani.play("IdleLeft")
		elif lastFacing == "upRight":
			ani.flip_h = true
			ani.play("IdleLeftUp")
		elif lastFacing == "downRight":
			ani.flip_h = true
			ani.play("IdleLeftDown")
		elif lastFacing == "upLeft":
			ani.flip_h = false
			ani.play("IdleLeftUp")
		elif lastFacing == "downLeft":
			ani.flip_h = false
			ani.play("IdleLeftDown")

	move_and_slide()
