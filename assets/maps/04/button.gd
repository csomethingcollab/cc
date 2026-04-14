class_name button extends Button

@export var connect_scene: String

var scene_folder = "res://assets/maps/04/"


func _on_pressed() -> void:
	var full_path = scene_folder + connect_scene + ".tscn"
	var scene_tree = get_tree()
	scene_tree.call_deferred("change_scene_to_file", full_path)

	if get_tree().current_scene.name == "Room 1":
		GlobalPosition.player_spawn_position = Vector2(1664,-32)
	if get_tree().current_scene.name == "Room 2":
		GlobalPosition.player_spawn_position = Vector2(512,1072)
	if get_tree().current_scene.name == "Room 3":
		GlobalPosition.player_spawn_position = Vector2(704,-512)
	if get_tree().current_scene.name == "Room 4":
		GlobalPosition.player_spawn_position = Vector2(1296,1232)
	if get_tree().current_scene.name == "Room 5":
		GlobalPosition.player_spawn_position = Vector2(-288,1152)
	if get_tree().current_scene.name == "Room 6":
		GlobalPosition.player_spawn_position = Vector2(-368,-368)
		print(get_tree().current_scene.name)
