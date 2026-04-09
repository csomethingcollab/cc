extends Node


signal set_hp(value)
signal set_enemy_hp(value)


var hp: int = 100:
	set(value):
			hp = value
			emit_signal("set_hp", value)

var enemy_hp: float = 200.0:
	set(value):
			enemy_hp = value
			emit_signal("set_enemy_hp", value)
			
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
