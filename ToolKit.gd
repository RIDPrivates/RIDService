extends Control

onready var tween = get_node("Tween")

var tween_map = {}

func slide(node, attribute, begin, end,
			callback_catcher=null, callback_funcion=null,
			trans=Tween.TRANS_CIRC, easing=Tween.EASE_OUT,
			duration=0.5):

	tween.interpolate_property(node, attribute, begin, end, duration, trans, easing)
	if callback_catcher == null:
		tween_map.erase(str(node) + ":" + attribute)	
	else:
		tween_map[str(node) + ":" + attribute] = [callback_catcher, callback_funcion]
	tween.connect("tween_completed", self, "_slide_done")
	tween.start()
	return tween

func _slide_done(object, key):
	if str(object) + key in tween_map.keys():
		tween_map[str(object) + key][0].call(tween_map[str(object) + key][1])
		tween_map.erase(str(object) + key)	
