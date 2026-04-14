class_name Roomtrigger extends Area2D

@export var connect_scene: String
@export var next_spawn_position = Vector2(576, 336)
var scene_folder = "res://assets/maps/04/"
 
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var full_path = scene_folder + connect_scene + ".tscn"
		var scene_tree = get_tree()
		scene_tree.call_deferred("change_scene_to_file", full_path)
		GlobalPosition.player_spawn_position = next_spawn_position
		
