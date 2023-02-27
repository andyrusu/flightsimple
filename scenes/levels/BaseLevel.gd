extends Node2D
class_name BaseLevel

@export var playerInitialPosition = Vector2(360, 1330)
@export var playerSpawnPosition = Vector2(360, 880)
@export var playerSpawnSpeed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnPlayer(playerNode:CharacterBody2D):
	playerNode.position = playerInitialPosition
	var tween = playerNode.create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(playerNode, "position", playerSpawnPosition, playerSpawnSpeed)
	tween.finished.connect(playerNode.fire)
