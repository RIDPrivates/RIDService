extends Button

var size
var hover_rate = 0

func _ready():
	size = self.get_size()

func _draw():
	if hover_rate > 0.01:
		draw_line(
			Vector2(0, 0),
			Vector2(self.size.x, 0) * hover_rate,
			Color.white
		)
		draw_line(
			Vector2(0, 0),
			Vector2(0, self.size.y) * hover_rate,
			Color.white
		)
		draw_line(
			self.size - Vector2(self.size.x, 0) * hover_rate,
			self.size,
			Color.white
		)
		draw_line(
			self.size - Vector2(0, self.size.y) * hover_rate,
			self.size,
			Color.white
		)


func _process(delta):
	if self.is_hovered():
		hover_rate += float(1-hover_rate) / 10
	else:
		hover_rate -= float(hover_rate) / 10
	self.set_size(size)
	self.update()
