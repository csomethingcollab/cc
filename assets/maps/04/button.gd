class_name button extends Button

@export var connect_scene: String
var scene_folder = "res://assets/maps/04/"


func _on_pressed() -> void:
	var full_path = scene_folder + connect_scene + ".tscn"
	var scene_tree = get_tree()
	scene_tree.call_deferred("change_scene_to_file", full_path)
