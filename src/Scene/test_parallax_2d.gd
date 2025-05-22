extends Node2D
@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var v_box_container: VBoxContainer = $HUD/Control/ScrollContainer/VBoxContainer
@onready var timer_check_file_update: Timer = $TimerCheckFileUpdate

var parallaxList:Array[ParallaxLayer] = []
var configList:Array[LayerConfig] = []
var img_path_list:Array[String] = []
var last_modify:Array[int] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var c_count:int = parallax_background.get_child_count()
	for i in range(c_count-1,-1,-1):
		var pl = parallax_background.get_child(i)
		parallaxList.append(pl)
		
		var lconfig:LayerConfig = preload("res://Assets/LayerConfig/layer_config.tscn").instantiate()
		lconfig.layer_name = pl.name
		lconfig.parallaxLayer = pl
		v_box_container.add_child(lconfig)
		lconfig.visible = false
		configList.append(lconfig)
	pass # Replace with function body.


func _on_open_dir_text_changed(new_text: String) -> void:
	for i in configList:
		i.visible = false
		
	var index:int = 0
	img_path_list.clear()
	for f in DirAccess.get_files_at(new_text):
		if not f.to_lower().ends_with(".png"):
			continue
		var abs_path:String = "%s/%s"%[new_text,f]
		img_path_list.append(abs_path)
		index += 1
		if index >= 11:
			break
	
	index = 0
	for abs_path in img_path_list:
		print(abs_path)
		configList[index].visible = true
		
		var img:Image = Image.load_from_file(abs_path)
		configList[index].mirroring_x = img.get_size().x*4
		configList[index].scale_x = remap(index,0,img_path_list.size(),1,0)
		configList[index].scale_y = remap(index,0,img_path_list.size(),1,0)
		configList[index].update_var2node()
		last_modify.append(FileAccess.get_modified_time(abs_path))
		index += 1
	update_image()
	pass
	
func update_image():
	var index:int = 0
	for abs_path in img_path_list:
		for n in parallaxList[index].get_children():
			n.queue_free()
		
		var img:Image = Image.load_from_file(abs_path)
		var texture:ImageTexture = ImageTexture.create_from_image(img)
		# == 1 ==
		var sprite:Sprite2D = Sprite2D.new()
		sprite.texture = texture
		parallaxList[index].add_child(sprite)
		# == 2 ==
		sprite = Sprite2D.new()
		sprite.texture = texture
		sprite.position.x = img.get_size().x
		parallaxList[index].add_child(sprite)
		# == 3 ==
		sprite = Sprite2D.new()
		sprite.texture = texture
		sprite.position.x = img.get_size().x*2
		parallaxList[index].add_child(sprite)
		# == 4 ==
		sprite = Sprite2D.new()
		sprite.texture = texture
		sprite.position.x = img.get_size().x*3
		parallaxList[index].add_child(sprite)
		
		index += 1
	
func _on_timer_check_file_update_timeout() -> void:
	var file_changed:bool = false
	for i in img_path_list.size():
		var current_mod_time:int = FileAccess.get_modified_time(img_path_list[i])
		if current_mod_time != last_modify[i]:
			last_modify[i] = current_mod_time
			file_changed = true
	if file_changed:
		update_image()
	pass # Replace with function body.
