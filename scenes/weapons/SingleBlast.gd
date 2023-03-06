extends Area2D

@export var speed = 500
@export var direction = Vector2.UP
@export var damage = 1
@export var is_reverse = false

var ignore:String

# Called when the node enters the scene tree for the first time.
func _ready():
	var database = TextDatabase.new()
	database.load_from_path("res://res/weapons.cfg")
	var weaponDetails = database.get_dictionary().get("SingleBlast")
	
	speed = weaponDetails.speed
	damage = weaponDetails.damage
	
	if is_reverse:
		rotation_degrees = 90
		direction = Vector2.RIGHT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed * direction * delta

func _on_body_entered(body):
	if body is StaticBody2D && body.name == "TopWall":
		queue_free()
	if body is CharacterBody2D && body.name != ignore:
		queue_free()
		body.hit(damage)
