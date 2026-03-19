extends CharacterBody2D

const SPEED = 200.0
const MAX_SPEED = 100.0
const AIR_RES = 0.7


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal := Input.get_axis("Left", "Right")
	var vertical := Input.get_axis("Up", "Down")
	
	var direction := Vector2(horizontal, vertical)
	
	if !direction.is_zero_approx():
		velocity += direction.normalized() * SPEED * delta
		if velocity.length() > MAX_SPEED:
			velocity = velocity.normalized() * MAX_SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, AIR_RES)
	
	move_and_slide()

	# Change l'orientation
	if velocity.x != 0:
		$Sprite.flip_h = (velocity.x < 0)
