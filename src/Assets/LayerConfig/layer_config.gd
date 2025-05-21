extends PanelContainer
class_name LayerConfig

@export var parallaxLayer:ParallaxLayer
@export var layer_name:String = "Layer0"
@export var scale_x:float = 1.0
@export var scale_y:float = 1.0
@export var offset_x:float = 0.0
@export var offset_y:float = 0.0
@export var mirroring_x:float = 0.0
@export var mirroring_y:float = 0.0

@onready var layer_label: Label = $VBoxContainer/LayerName
@onready var Sx: LineEdit = $VBoxContainer/Scale/X
@onready var Sy: LineEdit = $VBoxContainer/Scale/Y
@onready var Ox: LineEdit = $VBoxContainer/Offset/X
@onready var Oy: LineEdit = $VBoxContainer/Offset/Y
@onready var Mx: LineEdit = $VBoxContainer/Mirroring/X
@onready var My: LineEdit = $VBoxContainer/Mirroring/Y

@onready var element_list:Array[LineEdit] = [Sx,Sy,Ox,Oy,Mx,My]
@onready var variable_list:Array[String] = ["scale_x","scale_y","offset_x","offset_y","mirroring_x","mirroring_y"]

var t:Vector2 = Vector2.ZERO

func _ready() -> void:
	update_var2node()

	for i in range(len(element_list)):
		element_list[i].text_changed.connect(update_node2var.bind(variable_list[i]))

func update_node2var(value:String, variable:String):
	set(variable,float(value))
	_update_to_parallax()
	pass

func update_var2node():
	layer_label.text = layer_name
	for i in range(len(element_list)):
		element_list[i].text = str(get(variable_list[i]))
	_update_to_parallax()
	pass

func _update_to_parallax():
	if parallaxLayer:
		parallaxLayer.motion_scale = Vector2(scale_x,scale_y)
		parallaxLayer.motion_offset = Vector2(offset_x,offset_y)
		parallaxLayer.motion_mirroring = Vector2(mirroring_x,mirroring_y)
