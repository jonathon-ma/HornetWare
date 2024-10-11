extends Node2D
const games_path = "res://Games/"
var game_dirs

# Settings

# Game Vars
var game
var points = 0

func _ready() -> void:
	game_dirs = DirAccess.get_directories_at(games_path)

func _on_main_menu_begin() -> void:
	$MainMenu.visible = false
	begin_game()

# Game Loop Functions
func begin_game() : 
	var game_path = get_main_path(get_rand_dir())
	game = load_scene(game_path)
	print(game_path)
	self.add_child(game)
	$GameTimer.start()

func end_game() : 
	if(game.has_method("hasWon") && game.hasWon()): points += 1
	print("Points: " + str(points))
	self.remove_child(game)
	$MainMenu.visible = true

func _on_game_timer_timeout() -> void:
	end_game()

# Game Selector Functions
func load_scene(path: String) -> Node :
	var result : Node = null
	if ResourceLoader.exists(path) : 
		result = ResourceLoader.load(path).instantiate()
	
	return result

func get_main_path(dir: String) -> String :
	return games_path + dir + "/main.tscn"

func get_rand_dir() -> String :
	return game_dirs[randi_range(0, game_dirs.size() - 1)]
