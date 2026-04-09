extends Node

var collected_items: Dictionary = {}
var placed_items: Dictionary = {}

func mark_collected(scene_name: String, item_id: String) -> void:
	if not collected_items.has(scene_name):
		collected_items[scene_name] = []
	if item_id not in collected_items[scene_name]:
		collected_items[scene_name].append(item_id)

func is_collected(scene_name: String, item_id: String) -> bool:
	return collected_items.has(scene_name) and item_id in collected_items[scene_name]

func set_item_state(scene_name: String, item_id: String, position: Vector2) -> void:
	if not placed_items.has(scene_name):
		placed_items[scene_name] = {}
	placed_items[scene_name][item_id] = {
		"position": position
	}

func get_item_state(scene_name: String, item_id: String) -> Dictionary:
	if placed_items.has(scene_name) and placed_items[scene_name].has(item_id):
		return placed_items[scene_name][item_id]
	return {}
	
func get_total_collected_count() -> int:
	var total = 0
	for scene in collected_items:
		total += collected_items[scene].size()
	return total

func has_enough_collected(scene_name: String, required_count: int) -> bool:
	if not collected_items.has(scene_name):
		return false
	return collected_items[scene_name].size() >= required_count
	
func all_collected(scene_name: String, required_items: Array) -> bool:
	if not collected_items.has(scene_name):
		return false
	for item in required_items:
		if item not in collected_items[scene_name]:
			return false
	return true
