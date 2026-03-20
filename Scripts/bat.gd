extends CharacterBody2D

const SPEED = 300.0
const DASH_SPEED = 500.0
const MAX_SPEED = 100.0
const AIR_RES = 3

signal new_scan(lines: PackedVector2Array)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction
	var horizontal := Input.get_axis("Left", "Right")
	var vertical := Input.get_axis("Up", "Down")
	
	#gerer l'echo
	if Input.is_action_just_pressed("Echo"):
		scan_walls()
		new_scan.emit(scan_lines)

	if Input.is_action_just_pressed("Dash"):
		$Dash.start()
		velocity = velocity.normalized() * DASH_SPEED
	
	if $Dash.is_stopped():
		direction = Vector2(horizontal, vertical).normalized()
		
		if !direction.is_zero_approx():
			velocity += direction * SPEED * delta
			if velocity.length() > MAX_SPEED:
				velocity = velocity.normalized() * MAX_SPEED
		
	velocity = velocity.move_toward(Vector2.ZERO, AIR_RES)
	
	move_and_slide()

	# Change l'orientation
	if velocity.x != 0:
		$Sprite.flip_h = (velocity.x < 0)

var scan_lines: PackedVector2Array
const SCAN_RANGE = 200
const SCAN_PRECISION = 4096

func scan_walls():
	var angle
	var points: PackedVector2Array
	
	scan_lines = []
	
	for i in SCAN_PRECISION:
		angle = 2 * PI * i/SCAN_PRECISION
		$RayCast2D.target_position = Vector2.from_angle(angle) * SCAN_RANGE
		
		$RayCast2D.force_raycast_update()
		
		if $RayCast2D.is_colliding() == true:
			points.append($RayCast2D.get_collision_point())
			
	if points.size() >= 2:
		scan_lines = points.duplicate()
