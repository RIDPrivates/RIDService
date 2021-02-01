extends Node

const NECESSARY = true
const UNNECESSARY = false

func _ready():
	var example = Pattern.new(
		[
			Print.new(
				'print',
				NECESSARY
			),
			Value.new(
				'value',
				NECESSARY
			)
		],
		'print'
	)
	example.components_map['value'].value = 5
	call(example.action, example)

func print(pattern):
	print(pattern.components_map['value'].value)

class Component extends Object:
	var necessity
	var type
	var name
	var value
	
	func _init(name, necessity):
		self.necessity = necessity
		self.name = name

class Value extends Component:
	func _init(name, necessity).(name, necessity):
		pass

class Print extends Component:
	func _init(name, necessity).(name, necessity):
		pass

class Pattern extends Object:
	var pattern_components
	var components_map
	var action

	func _init(components, action):
		self.components_map = {}
		for component in components:
			if component.name != null:
				self.components_map[component.name] = component
		self.pattern_components = components
		self.action = action

	func fill(code):
		for code_component in code.split(" "):
			print(code_component)
	func run(code):
		pass
	func match(code):
		return true
