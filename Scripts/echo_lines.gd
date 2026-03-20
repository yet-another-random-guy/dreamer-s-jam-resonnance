extends Node2D

var scan_lines: Array[PackedVector2Array]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _draw() -> void:
	for points in scan_lines:
		if points.size() < 2:
			continue
		draw_polyline(points, Color(255, 255, 255), 1)

func _on_bat_new_scan(lines: Array[PackedVector2Array]) -> void:
	scan_lines = lines
	print("hello")
	queue_redraw()
	pass # Replace with function body.
