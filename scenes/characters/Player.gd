extends CharacterBody2D

var is_mouse_pressed:bool = false
var is_moving:bool = false

var currentWeapon:String = "SingleBlast"
var weaponDetails:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	#Setting up input
	Input.set_use_accumulated_input(false)
	
	#Setting up database
	var database = TextDatabase.new()
	database.load_from_path("res://res/weapons.cfg")
	
	#Setting up weapon
	weaponDetails = database.get_dictionary().get(currentWeapon)
	var currentWeaponNode = load("res://scenes/weapons/" + currentWeapon + ".tscn").instantiate()
	print(weaponDetails.get("fireRate", 10))
	$FireRate.wait_time = weaponDetails.get("fireRate", 10)
	$FireRate.timeout.connect(fire)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_moving = false
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
	var weaponNode = load("res://scenes/weapons/" + currentWeapon + ".tscn").instantiate()
	weaponNode.position = position
	get_parent().add_child(weaponNode)
	
	if $FireRate.is_stopped():
		$FireRate.start()
