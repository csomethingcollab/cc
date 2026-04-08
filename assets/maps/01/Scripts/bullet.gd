extends Node2D

func _process(delta):
	self.position += Vector2(1,0).rotated(self.rotation)
	
	if ($RayCast2d.is_colliding()):
		print("ow")
