extends "res://scenes/core/ControlBase.gd"

var button_set

onready var Typer = load("res://scenes/core/Typer.tscn")
onready var ButtonBase = load("res://scenes/core/ButtonBase.tscn")

var label

var drop_rate = 0
var max_width = 0

func _draw():
	if visible:
		var pos = get_size()
		pos.x /= 16
		pos.y = pos.x
		draw_arc(pos, pos.length()/8, 0, 2 * PI * drop_rate, 80,  Color.white)

		draw_line(
			pos,
			pos + Vector2(
				0,
				button_set.get_size().y * drop_rate
			),
			Color.white
		)

		
		button_set.set_position(pos)

enum ShortcutMode{
	AUTO,
	INITIAL,
	NUMBER
}

signal done(selected, choice)

func _process(delta):
	update()

func _ready():
	button_set = VBoxContainer.new()
	add_child(button_set)
	hide()

func present(choices, shortcut_mode=ShortcutMode.AUTO):
	max_width = 0
	remove_child(button_set)
	button_set = VBoxContainer.new()
	add_child(button_set)
	for button in button_set.get_children():
		button_set.remove_child(button)
		button.queue_free()

	var font = ButtonBase.instance().get_font("")
	for choice in choices:
		var _size = font.get_string_size(" " + choice["text"])
		max_width = max(max_width, _size.x)

	max_width += 20

	for choice in choices:
		var button = ButtonBase.instance()
		button.clip_text = true
		button.text = " " + choice['text']
		button.connect("pressed", self, "_selected", [choice['text']])
		button_set.add_child(button)
		
		ToolKit.slide(button, "size", button.size, Vector2(max_width,button.size.y))

	grab_focus()
	ToolKit.slide(self, "drop_rate", self.drop_rate, 1)
	match shortcut_mode:
		ShortcutMode:
			pass
	
	show()
func _selected(text):
	emit_signal("done", true, text)

func retract():

	for button in button_set.get_children():
		button.clip_text = true
		ToolKit.slide(button, "size", button.size, Vector2(0, button.size.y))
	self.release_focus()
	ToolKit.slide(self, "drop_rate", self.drop_rate, 0, self, "_retracted")

func _retracted():
	hide()

func _input(event):
	pass
