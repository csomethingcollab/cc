class_name Player extends CharacterBody2D

const AIR_SPEED = 40
const SPEED = 200
const JUMP_SPEED = 240
const GRAVITY = 500

@export var state: States = States.TopDown

enum States {
	TopDown,
	SideView,
	Dead
}

var logger

func _ready() -> void:
	logger = load("res://src/utils/logger.gd").new("Player")

func _physics_process(delta: float) -> void:
	match (state):
		States.SideView:
			motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED

			velocity.x = 0

			if (Controls.X):
				velocity.x = Controls.X * SPEED
			elif (velocity.x != 0):
				velocity.x -= 20
			
			if (!is_on_floor()):
				velocity += get_gravity() * delta

			if (Controls.JUMP && is_on_floor()):
				velocity.y = -JUMP_SPEED
			move_and_slide()
		States.TopDown:
			motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

			velocity.x = 0
			velocity.y = 0
			
			if (Controls.X):
				velocity.x = Controls.X * SPEED
			elif (velocity.x != 0):
				velocity.x -= 20

			if (Controls.Y):
				velocity.y = Controls.Y * SPEED
			elif (velocity.y != 0):
				velocity.y -= 20

			move_and_slide()
		States.Dead:
			pass
		