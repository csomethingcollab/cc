class_name PlayerL4 extends CharacterBody2D
@export var is_final = false
var triggered = false
const b = -1600

var Key1_collected = false
var Key2_collected = false
var Key3_collected = false
var Key4_collected = false
var Key5_collected = false
var Key6_collected = false

func _ready():
	global_position = GlobalPosition.player_spawn_position

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if not triggered:
		velocity = input_dir * 300
	else:
		velocity = Vector2(0,0)
	if is_final:
		velocity.y = 0
	move_and_slide()
	
	if position.x < b:
		position.x = b
	if position.y < b and not is_final:
		position.y = b
	if position.y > 3000 and not is_final:
		position.y = 3000
	if position.x > 3000:
		position.x = 3000
