class_name Scenetrigger extends Area2D

@export var connect_scene: String
var scene_folder = "res://assets/maps/04/"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var scene_name = get_tree().current_scene.name
		if GameState.get_total_collected_count() >= 3:
			var full_path = scene_folder + connect_scene + ".tscn"
			get_tree().call_deferred("change_scene_to_file", full_path)
		else:
			print("Not enough keys!")
