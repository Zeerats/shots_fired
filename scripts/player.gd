extends CharacterBody3D

@onready var head = $HeadPivot

const SPEED = 8.0
const JUMP_VELOCITY = 5.0
const GRAVITY = 15.0

var mouse_sens_y = 0.5
var mouse_sens_x = 0.5

func _ready():
	# Set player to instance.
	GameManager.player = self
	# Capture mouse inside screen.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Quit game if exit is pressed.
	if event.is_action("exit"):
		get_tree().quit()
	
	# Rotate camera and clamp to vertical axis.
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens_y * 0.1))
		head.rotate_x(deg_to_rad((-event.relative.y * mouse_sens_x * 0.1)))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	# Apply fall velocity.
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	# Handle jumping.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle directions and input.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
