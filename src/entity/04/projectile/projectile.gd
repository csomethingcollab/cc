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
	var direction := Vector2(Controls.X, Controls.Y).normalized()

	# Move the Area2D
	position += direction * speed * delta

func _on_lifespan_timeout() -> void:
		six.swap_camera()
		six.stateReset()
		self.queue_free()

#func _on_body_entered(body: Node2D) -> void:
	
