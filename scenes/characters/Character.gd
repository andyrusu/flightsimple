extends CharacterBody2D
class_name Character

@export var health = 1
@export var speed = 1000

var currentWeapon:String = "SingleBlast"
var weaponDetails:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	#Setting up database
	var database = TextDatabase.new()
	database.load_from_path("res://res/weapons.cfg")
	
	#Setting up weapon
	weaponDetails = database.get_dictionary().get(currentWeapon)
	var currentWeaponNode = load("res://scenes/weapons/" + currentWeapon + ".tscn").instantiate()
	$FireRate.wait_time = weaponDetails.get("fireRate", 10)
	$FireRate.timeout.connect(fire)

func start():
	fire()

func fire():
	var weaponNode = load("res://scenes/weapons/" + currentWeapon + ".tscn").instantiate()
	weaponNode.ignore = name
	weaponNode.position = position
	get_parent().add_child(weaponNode)
	
	if $FireRate.is_stopped():
		$FireRate.start()

func hit(damage):
	health -= damage
	
	if health <= 0:
		die()

func die():
	queue_free()
