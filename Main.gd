extends Control

onready var content = get_node("Content")
onready var compiler = load("res://ridlang/compiler/Compiler.gd")
onready var quick_selector = load("res://scenes/core/QuickSelector.tscn").instance()
onready var ridbash_compiler = load("res://services/terminal/ridbash/Compiler.gd")
var start_size = Vector2(800, 500)

func _ready():
	add_child(quick_selector)
	OS.window_borderless = true
	get_tree().get_root().set_transparent_background(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ToolKit.slide(OS, "window_size", Vector2(0, 0), start_size)
	ToolKit.slide(OS, "window_position", Vector2(0, 0), OS.get_screen_size()/2 - start_size/2)
	# Test
	compiler.new()._ready()
	var _size = get_size()
	_size.x /= 8
	quick_selector.set_size(_size)
	var file = File.new()
	file.open("C:\\Users\\User\\Desktop\\RIDDoc\\test.ridbash", File.READ)	
	ridbash_compiler.compile(file.get_as_text())
	file.close()

func on_service_selected(selected, choice):
	if selected:
		print(choice)
func _on_service_selected(selected, choice):
	remove_child(content)
	content = Services.map[choice].instance()
	add_child(content)
	move_child(content, 0)
	content.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_alter"):
		var presentation = []
		for name in Services.map.keys():
			presentation.append({'icon': Assets.icons["terminal"], 'text': name})
		quick_selector.present(presentation)
		quick_selector.connect("done", self, "_on_service_selected")

	elif event.is_action_released("ui_alter"):
		quick_selector.retract()

	if get_focus_owner() == null:
		if event.is_action_pressed("ui_down"):
			var x = OS.get_screen_size().x/2 - start_size.x/2
			var y = OS.get_screen_size().y - start_size.y
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))
			
		if event.is_action_pressed("ui_up"):
			var x = OS.get_screen_size().x/2 - start_size.x/2
			var y = 0
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))
			
		if event.is_action_pressed("ui_center"):
			var x = OS.get_screen_size().x/2 - start_size.x/2
			var y = OS.get_screen_size().y/2 - start_size.y/2
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))

		if event.is_action_pressed("ui_left_up"):
			var x = 0
			var y = 0
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))

		if event.is_action_pressed("ui_left_down"):
			var x = 0
			var y = OS.get_screen_size().y - start_size.y
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))

		if event.is_action_pressed("ui_right_up"):
			var x = OS.get_screen_size().x - start_size.x
			var y = 0
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))

		if event.is_action_pressed("ui_right_down"):
			var x = OS.get_screen_size().x - start_size.x
			var y = OS.get_screen_size().y - start_size.y
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))

		if event.is_action_pressed("ui_left"):
			var x = 0
			var y = OS.get_screen_size().y/2 - start_size.y/2
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))

		if event.is_action_pressed("ui_right"):
			var x = OS.get_screen_size().x - start_size.x
			var y = OS.get_screen_size().y/2 - start_size.y/2
			ToolKit.slide(OS, "window_position", OS.window_position, Vector2(x, y))

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		pass
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		quick_selector.retract()
