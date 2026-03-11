class_name Scenetrigger extends Area2D

@export var connect_scene: String
var scene_folder = "res://"



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var full_path = scene_folder + connect_scene + ".tscn"
		var scene_tree = get_tree()
		scene_tree.call_deferred("change_scene_to_file", full_path)
