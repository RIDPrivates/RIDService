extends Node

var example
onready var Component = load("res://ridlang/compiler/component.gd")
var basic_patterns = []

func _ready():
	var example_pattern = Component.Pattern.new(
		[],
		"_pattern_action_call"
	)
	basic_patterns.append(example_pattern)
	var example_code = """

Define pattern [print $value]:
	call \"print\" with value)
		"""
	var Compiler = load("./Compiler.gd")
	var _e = compile(example_code)

func compile(code):
	for pattern in basic_patterns:
		if pattern.match(pattern):
			pattern.fill(code)
			pattern.run()

func _pattern_action_call(func_name, args):
	call(func_name, args)
