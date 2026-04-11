extends Camera2D

@onready var node: Node = $".."

func _process(delta: float) -> void:
	followProjectile()

## Sets the camera's position to the projectile's position if one is found.
func followProjectile() -> void:
	# FIXME: set this to fire on an event instead of checking every single frame
	if node.has_node("projectile"):
		var proj = get_parent().get_node("projectile")
		self.position = proj.position
