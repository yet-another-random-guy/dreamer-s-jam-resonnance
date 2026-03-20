extends Node2D

var scan_points: PackedVector2Array
const MAX_DISTANCE = 10

func _draw() -> void:
	if scan_points.size() < 2:
		return
	
	var point1: Vector2
	var point2: Vector2
	var col: Color = Color(255, 255, 255)
	
	print(scan_points.size())
	
	for index in (scan_points.size()):
		point1 = scan_points[index]
		
		if index + 1 < scan_points.size():
			point2 = scan_points[index + 1]
		else:
			point2 = scan_points[0]
		
		if point1.distance_to(point2) <= MAX_DISTANCE:
			draw_line(point1, point2, col, 1)

func _on_bat_new_scan(points: PackedVector2Array) -> void:
	scan_points = points
	queue_redraw()
	pass # Replace with function body.
