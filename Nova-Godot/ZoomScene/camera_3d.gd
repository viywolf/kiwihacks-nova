extends CharacterBody3D

signal earth_reached

var max_velocity := Vector3(0.3 ,0, 0.3)
var cur_velocity: Vector3
var acceleration: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.z > 36.845:
		max_velocity = Vector3(1, 0, 1)
	else:
		max_velocity = Vector3(0.3, 0, 0.3)
	if Input.is_action_pressed("forward"):
		if velocity.z < 0:
			velocity.z = lerp(velocity.z, 0.0, 4 * acceleration * delta)
		velocity.z += acceleration * delta
	elif Input.is_action_pressed("backward"):
		if velocity.z > 0:
			velocity.z = lerp(velocity.z, 0.0, 4 * acceleration * delta)
		velocity.z -= acceleration * delta
	else:
		velocity.z = lerp(velocity.z, 0.0, 2 * acceleration * delta)
		
	if velocity.z > max_velocity.z:
		velocity.z = max_velocity.z
	elif velocity.z < -max_velocity.z:
		velocity.z = -max_velocity.z
	move_and_slide()
