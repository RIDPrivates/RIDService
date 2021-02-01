extends Node

var example
onready var Component = load("res://ridlang/compiler/component.gd")
var basic_patterns = []

func _ready():
	var example_pattern = Component.Pattern.new(
		[Component.Text.new("CALL"), Component.Value.new("value")],
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
	var tree = chunkize(code)
	var pattern_tree = realize(tree)

func realize(node):
	for pattern in self.basic_patterns:
		if pattern.match(node):
			pattern.fill(node)
			return pattern.duplicate()


func _pattern_action_call(func_name, args):
	call(func_name, args)

class RLTreeNode:
	var parent = null
	var children = []
	var indentation = 0
	var line = ""
	func _init(parent=null, indentation=0, line=""):
		self.parent = parent
		self.indentation = indentation
		self.line = line

func chunkize(raw):
	var root = RLTreeNode.new()
	var indentations = []
	var current_node = root
	for line in raw.split("\n"):
		var line_indentation = 0
		var indenting = true
		for character in line:
			if character == " " and indenting:
				line_indentation += 1
			else:
				indenting = false
				indentations.append(line_indentation)
		if line_indentation < current_node.indentation:
			current_node  = current_node.parent

		var node = RLTreeNode.new(current_node, line_indentation, line)
		current_node.children.append(node)

		if line.ends_with(":"):
			current_node = node

	return root
