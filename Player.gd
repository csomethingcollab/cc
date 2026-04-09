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

const speed := 800
const isometric_ratio := (232.0 / 145.0)

func _physics_process(delta: float) -> void:
	ani.flip_h = false       # reset this, we set it to true during the movement processes
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
			velocity = direction * speed
			velocity.x *= isometric_ratio
			
			if (velocity.x > 0):
				ani.flip_h = true
			var movement_directions: Array[Array] = [
				["upLeft", "up", "upRight"],
				["left", null, "right"],
				["downLeft", "down", "downRight"]
			]
			lastFacing = movement_directions[sign(direction.y) + 1][sign(direction.x) + 1]
			ani.play("Walk" + lastFacing.replacen("Right", "Left").to_pascal_case())
			
		else:
			velocity = Vector2.ZERO

			if lastFacing.containsn("Right"):
				ani.flip_h = true
			ani.play("Idle" + lastFacing.replacen("Right", "Left").to_pascal_case())

		move_and_slide()

	elif state != "attacking":
		if Input.is_action_just_pressed("basicAttack"):
			basicAttack()
		elif Input.is_action_just_pressed("secondAttack"):
			secondAttack()

func basicAttack():
	velocity = Vector2.ZERO
	state = "attacking"
	_8_frame_timer.start()
	if lastFacing.containsn("Right"):
		ani.flip_h = true
	ani.play("Prime" + lastFacing.replacen("Right", "Left").to_pascal_case())

func secondAttack():
	velocity = Vector2.ZERO
	state = "attacking"
	_8_frame_timer.start()
	if lastFacing.containsn("Right"):
		ani.flip_h = true
	ani.play("Sec" + lastFacing.replacen("Right", "Left").to_pascal_case())
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
