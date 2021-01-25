extends LineEdit

onready var terminal = get_node("../../../")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		terminal.process_command(self.text)
		self.text = ""
