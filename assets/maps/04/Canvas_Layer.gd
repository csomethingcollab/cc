extends CanvasLayer

@onready var inventory = $Inventory

func _ready() -> void:
	inventory .close()

func _input(event):
	if event. is_action_pressed("inventory"):
		if inventory .isOpen:
			inventory .close()
		else:
			inventory .open()
