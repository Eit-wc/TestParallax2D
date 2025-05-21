extends LineEdit

@onready var file_dialog: FileDialog = $FileDialog

func _ready() -> void:
	file_dialog.visible = false

func _on_browse_pressed() -> void:
	file_dialog.visible = true
	pass # Replace with function body.


func _on_file_dialog_file_selected(path: String) -> void:
	text = path
	text_changed.emit(text)
	pass # Replace with function body.


func _on_file_dialog_dir_selected(dir: String) -> void:
	text = dir
	text_changed.emit(text)
	pass # Replace with function body.
