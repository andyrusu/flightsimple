extends Area2D

@onready var direction = Vector2(0.0, -1.0)
@onready var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + speed * direction * delta


func _on_body_entered(body):
	if body is StaticBody2D && body.name == "TopWall":
		queue_free()
