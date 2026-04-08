extends Node2D

var bullet_scene = load("res://assets/maps/01/bullet.tscn")
func _process(delta):
	rotate(.1)
	
	var b = bullet_scene.instantiate()
	b.position = self.position
	b.rotation = self.rotation
	get_parent().add_child(b)
