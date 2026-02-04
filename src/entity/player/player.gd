class_name Player extends CharacterBody2D

const AIR_SPEED = 40
const SPEED = 200
const JUMP_SPEED = 180
const GRAVITY = 500

var logger

func _ready() -> void:
	logger = load("res://src/utils/logger.gd").new("Player")

func _physics_process(delta: float) -> void:
	velocity.x = 0

	if (Controls.X):
		velocity.x = Controls.X * SPEED
	elif (velocity.x != 0):
		velocity.x -= 20
	
	# Add the gravity.
	if (!is_on_floor()):
		velocity += get_gravity() * delta

	if (Controls.JUMP && is_on_floor()):
		velocity.y = -JUMP_SPEED
	
	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction := Input.get_axis("ui_left", "ui_right")
	# if direction:
	# 	velocity.x = direction * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# var collision = move_and_collide(velocity * delta)
	# if collision:
	# 	print("I collided with ", collision.get_collider().name)
	# 	velocity = velocity.slide(collision.get_normal())

## R
func update_input():
	# var current_velocity = velocity
	# current_velocity.x = 0

	var axis_x = Input.get_axis("move_left", "move_right")
	var axis_y = Input.get_axis("move_up", "move_down")

	# var right = Input.is_action_pressed("move_right")
	# var left = Input.is_action_pressed("move_left")
	# var up = Input.is_action_pressed("move_up")
	# var down = Input.is_action_pressed("move_down")
	# var jump = Input.is_action_pressed("jump")

	# if axis_x:
	# 	current_velocity += SPEED
