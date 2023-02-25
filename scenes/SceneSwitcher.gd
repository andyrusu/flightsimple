extends Node

func _ready():
	load_main_menu()
	
func load_main_menu():
	$MainMenu/Buttons/NewGameButton.pressed.connect(on_new_game_pressed)
	$MainMenu/Buttons/ExitGame.pressed.connect(on_quit_pressed);

func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instance()
	game_scene.connect("game_finished", self, "unload_game")
	add_child(game_scene)

func on_quit_pressed():
	get_tree().quit()

func unload_game():
	print('unloading')
	get_node("GameScene").queue_free()
	var main_menu = load("res://scenes/MainMenu.tscn").instance()
	add_child(main_menu)
	load_main_menu()
