extends Node

var example
onready var Component = load("res://ridlang/components/Component.tscn")
onready var Print = load("res://ridlang/components/Print.tscn")
onready var Pattern = load("res://ridlang/components/Print.tscn")

func _ready():
	print(Component)
	example = Pattern()
