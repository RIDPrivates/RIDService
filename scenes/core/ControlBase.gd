extends Control

func draw_circle_arc( center, radius, angle_from, angle_to, color ):
	var nb_points = 32
	var point_arcs = Array()
	
	for i in range(nb_points+1):
		var angle_point = angle_from + i*(angle_to-angle_from)/nb_points - 90
		var point = center + Vector2( cos(deg2rad(angle_point)), sin(deg2rad(angle_point)) )* radius
		point_arcs.push_back(point)
	
	for index in range(nb_points):
		draw_line(point_arcs[index], point_arcs[index+1], color)
