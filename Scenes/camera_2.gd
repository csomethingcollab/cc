extends Camera2D

@onready var node: Node = $".."

func _process(delta: float) -> void:
	if node.has_node("projectile"):
		var proj = get_parent().get_node("projectile")
		self.position = proj.position
