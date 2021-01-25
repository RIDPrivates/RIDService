static func compile(source):
	var parser = RegEx.new()
	parser.compile("\\w+ *\\[ *\\w* *\\] *\\:")
	for line in source.split("\n"):
		if not (line.begins_with("#") or line == ""):
			for a in parser.search_all(line):
				print(a.get_string())
				
