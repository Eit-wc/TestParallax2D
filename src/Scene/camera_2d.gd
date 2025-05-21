extends Camera2D
@export var speed:float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
		global_position -= event.relative * speed
	elif event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom -= Vector2.ONE * 0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom += Vector2.ONE * 0.1
	
func _on_camera_speed_value_changed(value: float) -> void:
	speed = remap(value,0,100,0,10)
	pass # Replace with function body.
