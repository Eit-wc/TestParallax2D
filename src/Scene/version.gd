extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ProjectSettings.get("application/config/version")
	pass # Replace with function body.
