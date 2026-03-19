extends CharacterBody2D

const SPEED = 300.0
const DASH_SPEED = 500.0
const MAX_SPEED = 100.0
const AIR_RES = 3


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction
	var horizontal := Input.get_axis("Left", "Right")
	var vertical := Input.get_axis("Up", "Down")
	
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
