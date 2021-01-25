extends "res://services/Service.gd"

onready var buffer = get_node("VBoxContainer/Buffer")
onready var input = get_node("VBoxContainer/HBoxContainer/Input")

# onready var tool_kit = get_node("ToolKit")

func realize_command(ridbash):
	pass

func process_command(command):
	execute_command(command)
	buffer.append_text(command + "\n")
	
func execute_command(command):
	pass

func message(msg):
	buffer.append_text(msg)
	pass


func _ready():
	pass

func load_preferences():
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if get_focus_owner() == null:
			input.grab_focus()
