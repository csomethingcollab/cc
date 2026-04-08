extends CharacterBody2D

@onready var ani: AnimatedSprite2D = $AnimatedSprite2D
@onready var _8_frame_timer: Timer = $"Timers/8frameTimer"
const PROJECTILE = preload("res://Scenes/projectile.tscn")
@onready var camera1: Camera2D = $Camera1
@onready var camera2: Camera2D = $"../Camera2"

var lastFacing = "down"
var state = "standing"

var last_diagonal := Vector2.ZERO
var diagonal_release_timer := 0.0
var diagonal_grace := 0.05

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.x != 0 and direction.y != 0:
		last_diagonal = direction
		diagonal_release_timer = 0.0

	elif last_diagonal != Vector2.ZERO and direction != Vector2.ZERO:
		diagonal_release_timer += delta

		if diagonal_release_timer < diagonal_grace:
			direction = last_diagonal
		else:
			last_diagonal = Vector2.ZERO

	if state != "attacking" and state != "tracking":
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

	if state != "attacking":
		if Input.is_action_just_pressed("basicAttack"):
			basicAttack()
		elif Input.is_action_just_pressed("secondAttack"):
			secondAttack()

func basicAttack():
	velocity = Vector2.ZERO
	state = "attacking"
	_8_frame_timer.start()
	if lastFacing == "down":
		ani.flip_h = false
		ani.play("Prime")
	elif lastFacing == "up":
		ani.flip_h = false
		ani.play("PrimeUp")
	elif lastFacing == "left":
		ani.flip_h = false
		ani.play("PrimeLeft")
	elif lastFacing == "right":
		ani.flip_h = true
		ani.play("PrimeLeft")
	elif lastFacing == "upRight":
		ani.flip_h = true
		ani.play("PrimeLeftUp")
	elif lastFacing == "downRight":
		ani.flip_h = true
		ani.play("PrimeLeftDown")
	elif lastFacing == "upLeft":
		ani.flip_h = false
		ani.play("PrimeLeftUp")
	elif lastFacing == "downLeft":
		ani.flip_h = false
		ani.play("PrimeLeftDown")

func secondAttack():
	velocity = Vector2.ZERO
	state = "attacking"
	_8_frame_timer.start()
	if lastFacing == "down":
		ani.flip_h = false
		ani.play("Sec")
	elif lastFacing == "up":
		ani.flip_h = false
		ani.play("SecUp")
	elif lastFacing == "left":
		ani.flip_h = false
		ani.play("SecLeft")
	elif lastFacing == "right":
		ani.flip_h = true
		ani.play("SecLeft")
	elif lastFacing == "upRight":
		ani.flip_h = true
		ani.play("SecLeftUp")
	elif lastFacing == "downRight":
		ani.flip_h = true
		ani.play("SecLeftDown")
	elif lastFacing == "upLeft":
		ani.flip_h = false
		ani.play("SeceLeftUp")
	elif lastFacing == "downLeft":
		ani.flip_h = false
		ani.play("SecLeftDown")
	var projectile = PROJECTILE.instantiate()
	projectile.six = self
	get_parent().add_child(projectile)
	projectile.position = self.position

func _on_frame_timer_timeout() -> void:
	if state == "attacking":
		state = "null"

func swap_camera() -> void:
	if get_viewport().get_camera_2d() == camera1:
		camera2.make_current()
	else:
		camera1.make_current()

func stateTrack():
	state = "tracking"

func stateReset():
	state = "null"
