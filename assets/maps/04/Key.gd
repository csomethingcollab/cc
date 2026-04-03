extends Area2D

@export var item_id: String 

func _ready():
	var scene_name = get_tree().current_scene.name
	if GameState.is_collected(scene_name, item_id):
		queue_free()
		
func _on_body_entered(body: Node2D) -> void:
	if body.name=="Player":
		var scene_name = get_tree().current_scene.name
		GameState.mark_collected(scene_name, item_id)
		queue_free()
