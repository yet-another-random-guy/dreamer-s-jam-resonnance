extends Node2D
const acceleration = 10.0
const air_res = 0.7
const max_spd = 5.0

var spd: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spd = Vector2.ZERO
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var accel = Vector2(0, 0)
	
	if Input.is_action_pressed("Right"):
		accel.x += 1
	if Input.is_action_pressed("Left"):
		accel.x -= 1
	if Input.is_action_pressed("Up"):
		accel.y -= 1
	if Input.is_action_pressed("Down"):
		accel.y += 1
	if Input.is_action_just_pressed("Dash") and $Dash.is_stopped():
		$Dash.start()
	
	accel = accel.normalized() * acceleration * delta
	
	if !$Dash.is_stopped():
		accel *= 10
	
	if accel == Vector2.ZERO:
		spd *= air_res
	else:
		spd += accel
		if spd.length() > max_spd and $Dash.is_stopped():
			spd = spd.normalized() * max_spd
	
	position += spd
	
	pass
