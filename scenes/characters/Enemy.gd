extends Character

@onready var pathNode:PathFollow2D = get_parent()

var can_move = false

func _physics_process(delta):
	if can_move:
		pathNode.progress += speed * delta

func start():
	can_move = true
	super.start()

func fire():
	var weaponNode = load("res://scenes/weapons/" + currentWeapon + ".tscn").instantiate()
	weaponNode.ignore = name
	weaponNode.position = position
	weaponNode.is_reverse = true
	get_parent().add_child(weaponNode)
	
	if $FireRate.is_stopped():
		$FireRate.start()
