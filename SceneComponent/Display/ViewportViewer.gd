"""
	Use this class for showing-up independent screens within the game.
	
	A modified version of a standard Godot's Viewport that will handle the input
	and distribute the events accordingly into viewport's UI controls.
	
	Assign the Context variable on the Inspector. Content is a scene that will be
	displayed within the screen (viewport) - usually contains UI Controls that player
	can click on the display.
"""

tool
extends Spatial

# Member variables
var prev_pos = null
var last_click_pos = null
var viewport: Node = null
var content_instance = null
export(PackedScene) var content = null
export(Vector2) var viewport_size = Vector2(ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height"))
export(bool) var hologram = false

# Mouse events for Area
func _on_area_input_event(_camera, event, click_pos, _click_normal, _shape_idx):
	# Use click pos (click in 3d space, convert to area space)
	var pos = get_node("Area").get_global_transform().affine_inverse()
	# the click pos is not zero, then use it to convert from 3D space to area space
	if (click_pos.x != 0 or click_pos.y != 0 or click_pos.z != 0):
		pos *= click_pos
		last_click_pos = click_pos
	else:
		# Otherwise, we have a motion event and need to use our last click pos
		# and move it according to the relative position of the event.
		# NOTE: this is not an exact 1-1 conversion, but it's pretty close
		pos *= last_click_pos
		if (event is InputEventMouseMotion or event is InputEventScreenDrag):
			pos.x += event.relative.x / viewport.size.x
			pos.y += event.relative.y / viewport.size.y
			last_click_pos = pos

	# Convert to 2D
	pos = Vector2(pos.x, pos.y)

	# Convert to viewport coordinate system
	# Convert pos to a range from (0 - 1)
	pos.y *= -1
	pos += Vector2(1, 1)
	pos = pos / 2

	# Convert pos to be in range of the viewport
	pos.x *= viewport.size.x
	pos.y *= viewport.size.y

	# Set the position in event
	event.position = pos
	event.global_position = pos
	if (prev_pos == null):
		prev_pos = pos
	if (event is InputEventMouseMotion):
		event.relative = pos - prev_pos
	prev_pos = pos

	# Send the event to the viewport
	viewport.input(event)


func _ready():
	set_process_input(false)
	viewport = get_node("Viewport")
	viewport.size = viewport_size
	if content != null:
		content_instance = content.instance()
		viewport.add_child(content_instance)
	else:
		Log.trace(self, "_ready", "Screen View without a content")
	
	get_node("Area").connect("input_event", self, "_on_area_input_event")
	
	if hologram:
		var mat = $Area/Quad.get_surface_material(0)
		mat.albedo_color.a = 0.7
		mat.flags_transparent = true
		$Area/Quad.set_surface_material(0, mat)
