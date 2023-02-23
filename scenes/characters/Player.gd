extends CharacterBody2D

var is_mouse_pressed = false
var is_moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_use_accumulated_input(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_moving = false
	fire()
	move_check_stop()

func _unhandled_input(event):
	if event.is_action_pressed("move"):
		is_mouse_pressed = true
	if event.is_action_released("move"):
		is_mouse_pressed = false
		
	if event is InputEventMouseMotion && is_mouse_pressed:
		is_moving = true
		set_velocity(event.velocity)

func move_check_stop():
	move_and_slide()
	if !is_moving:
		set_velocity(velocity.lerp(Vector2.ZERO, 0.25))

func fire():
	pass
