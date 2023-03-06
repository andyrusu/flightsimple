extends Character

var is_moving:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#Setting up input
	Input.set_use_accumulated_input(false)
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_moving = false
	move_check_stop()

func _unhandled_input(event):
	if event is InputEventScreenDrag:
		is_moving = true
		set_velocity(event.velocity)

func move_check_stop():
	var direction:Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		
	if direction != Vector2.ZERO:
		set_velocity(speed * direction)
	
	if !is_moving:
		set_velocity(velocity.lerp(Vector2.ZERO, 0.25))
	
	move_and_slide()
