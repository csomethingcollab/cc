extends Area2D
# gonna preface that this code was NOT made by me and i don't claim it to be.
# this code is by Eleeza Amin on youtube's bullet hell devlog!!
var speed = 100
var direction = Vector2.RIGHT
@export var texture: Texture2D
@export var hitbox: CircleShape2D = load("res://assets/maps/01/Sprites/bullet_hitbox.tres")

func _ready() -> void:
	$CollisionShape2d.shape = hitbox
	$Sprite2D.texture = texture

func _physics_process(delta: float) -> void:
	position += speed * direction * delta

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("ow")
		queue_free()
