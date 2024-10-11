extends Node2D
const games_path = "res://Games/"
var game_dirs

func _ready() -> void:
	game_dirs = DirAccess.get_directories_at(games_path)

func _on_main_menu_begin() -> void:
	begin_game_loop()
	$MainMenu.visible = false

# Game Loop Functions
func begin_game_loop() : 
	var game_path = get_main_path(get_rand_dir())
	print(game_path)
	self.add_child(load_scene(game_path))

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
