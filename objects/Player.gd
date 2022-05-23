extends KinematicBody2D

const ACCELERATION = 1000.0
const MAX_SPEED = 10000.0
const FRICTION = 1000.0
const ROTATION_SPEED = 1.0

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var curr_rot_speed = ROTATION_SPEED

func _physics_process(delta):
	direction = get_direction()
	update_rotation(delta)

	velocity = velocity.move_toward(direction.rotated(rotation) * MAX_SPEED * delta, ACCELERATION)
	velocity = move_and_slide(velocity)
	
func get_direction():
	return 	Vector2(0,Input.get_action_strength("move_up") - Input.get_action_strength("move_down"))

func update_rotation(delta):
	if velocity == Vector2.ZERO:
		curr_rot_speed /= 3
		
	if (Input.is_action_pressed("move_right") ):
		rotation += curr_rot_speed * delta
	elif(Input.is_action_pressed("move_left")):	
		rotation -= curr_rot_speed * delta

	curr_rot_speed = 1.0

	#speed = lerp(speed, MAX_SPEED, ACCELERATION * delta)
