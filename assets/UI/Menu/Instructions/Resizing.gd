extends ScrollContainer
func _ready() -> void:
	get_tree().get_root().connect("size_changed",self,"on_resize")
	
func on_resize() -> void:
	var oldsize = Vector2(1024, 700)
	var newsize = get_tree().get_root().get_visible_rect().size
	var scale = newsize.y/oldsize.y
	rect_scale = Vector2(1,1)*scale
