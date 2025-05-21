extends Node2D
@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var v_box_container: VBoxContainer = $HUD/Control/ScrollContainer/VBoxContainer

var parallaxList:Array[ParallaxLayer] = []
var configList:Array[LayerConfig] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var c_count:int = parallax_background.get_child_count()
	for i in range(c_count-1,-1,-1):
		var pl = parallax_background.get_child(i)
		parallaxList.append(pl)
		
		var lconfig:LayerConfig = preload("res://Assets/LayerConfig/layer_config.tscn").instantiate()
		lconfig.layer_name = pl.name
		lconfig.parallaxLayer = pl
		lconfig.scale_x = remap(i,10,0,2,0)
		lconfig.scale_y = remap(i,10,0,2,0)
		v_box_container.add_child(lconfig)
		lconfig.visible = false
		configList.append(lconfig)
	pass # Replace with function body.


func _on_open_dir_text_changed(new_text: String) -> void:
	for i in configList:
		i.visible = false
	
	var index:int = 0
	for f in DirAccess.get_files_at(new_text):
		if not f.to_lower().ends_with(".png"):
			continue
		var abs_path:String = "%s/%s"%[new_text,f]
		print(abs_path)
		configList[index].visible = true
		
		var img:Image = Image.load_from_file(abs_path)
		var texture:ImageTexture = ImageTexture.create_from_image(img)
		var sprite:Sprite2D = Sprite2D.new()
		sprite.texture = texture
		parallaxList[index].add_child(sprite)
		configList[index].mirroring_x = img.get_size().x
		#configList[index].offset_x = img.get_size().x*2
		#configList[index].offset_y = img.get_size().y
		configList[index].update_var2node()
		index += 1
		if index >= 11:
			break
		
		
	pass # Replace with function body.
