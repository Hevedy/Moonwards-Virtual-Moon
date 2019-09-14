#############################################
# This file is in use by yaelatletl         # 
# Do not edit                               # 
# Further commits to this file will be made #
#############################################
extends Control

var SceneOptions : PackedScene = preload("res://assets/UI/Options/Options.tscn")
var SceneMenu : PackedScene = preload("res://assets/UI/Menu/Main_menu.tscn")
var SceneDiagram : PackedScene = preload("res://assets/UI/Diagram.tscn")

var added_menu_ui : bool = false
var diagram_visible : bool = false

func _ready() -> void:
	UIManager.register_base_ui(self)

func _input(event):
	if event.is_action_pressed("ui_menu_options"):
		if added_menu_ui:
			UIManager.clear_ui()
			added_menu_ui = false
		elif UIManager.request_focus():
			UIManager.next_ui(SceneOptions)
			added_menu_ui = true
	if event.is_action_pressed("ui_cancel"):
		if added_menu_ui:
			UIManager.clear_ui()
			added_menu_ui = false
		elif UIManager.request_focus():
			UIManager.next_ui(SceneMenu)
			added_menu_ui = true
	if event.is_action_pressed("show_diagram"):
		if diagram_visible:
			UIManager.clear_ui()
			diagram_visible = false
		elif UIManager.request_focus():
			UIManager.next_ui(SceneDiagram)
			diagram_visible = true
