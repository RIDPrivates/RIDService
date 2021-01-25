extends RichTextLabel

var buffer = ""

func append_text(text):
	buffer += text

func _physics_process(delta):
	if buffer.length() > 0:
		self.text += buffer[0]
		buffer.erase(0, 1)


func flush():
	self.text += self.buffer
	self.buffer = ""
