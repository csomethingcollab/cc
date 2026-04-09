extends Area2D

# Movement speed in pixels per second
@export var speed: float = 400.0
@onready var lifespan: Timer = $Lifespan
var six = null

func _ready() -> void:
	await get_tree().create_timer(0.1)
	six.swap_camera()
	six.stateTrack()
	lifespan.start()

func _process(delta: float) -> void:
	var direction := Vector2.ZERO

	# Input handling (supports arrow keys and WASD)
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	# Normalize to prevent faster diagonal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	# Move the Area2D
	position += direction * speed * delta

func _on_lifespan_timeout() -> void:
		six.swap_camera()
		six.stateReset()
		self.queue_free()

#func _on_body_entered(body: Node2D) -> void:
	
