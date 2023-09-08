extends Node

onready var tileset = load("res://Assets/TileSet.tres")
onready var tilemap = load("res://Scenes/TileMap.tscn")
onready var level_scene = load("res://Scenes/Level.tscn")

const MIN_SCREENS = 8
const MAX_SCREENS = 8

onready var start_area = load("res://Generation/RequiredPieces/StartArea.tscn")
onready var end_area = load("res://Generation/RequiredPieces/EndArea.tscn")
onready var health_area = load("res://Generation/RequiredPieces/HealthArea.tscn")
onready var mobile_controls = load("res://Scenes/MobileControls.tscn")

var ascii_letters_and_digits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"


func _ready():
	randomize()
	generate_game_files("game")
	#create_level("test-level", tileset, tilemap, "res://Testing/test-level.tscn")


func gen_unique_string() -> String:
	randomize()
	var result = ""
	for i in range(11):
		result += ascii_letters_and_digits[randi() % ascii_letters_and_digits.length()]
	return result


func generate_screens_amount():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(MIN_SCREENS,MAX_SCREENS)

func create_level(levelname, tileset, tilemap, savepath):
	var pieces : Array
	var path = "res://Generation/LevelPieces/"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
			#get_next() returns a string so this can be used to load the images into an array.
			pieces.append(load(path + file_name))
	dir.list_dir_end()
	var level = level_scene.instance()
	level.set_name(levelname)
	var tile_map = tilemap.instance()
	level.add_child(tile_map)
	tile_map.set_owner(level)
	tile_map.tile_set = tileset
	var current_offset = 0
	var starting = start_area.instance()
	var start_tiles = starting.obtain_tiles()
	for a in start_tiles:
		var id = starting.obtain_tile_index(a)
		if id != 0:
			var object = load(convert_tile(id))
			var instance = object.instance()
			instance.set_name(gen_unique_string())
			level.add_child(instance)
			instance.position.x += a.x*16 + current_offset*16
			instance.position.y += a.y*16
			instance.set_owner(level)
		else:
			tile_map.set_cellv(a+Vector2(current_offset,0), 0)
	current_offset+=starting.obtain_size().x
	for i in generate_screens_amount():
		if i == 4:
			var healthspot = health_area.instance()
			var health_tiles = healthspot.obtain_tiles()
			for c in health_tiles:
				var id = healthspot.obtain_tile_index(c)
				print(id)
				if id != 0:
					var object = load(convert_tile(id))
					var instance = object.instance()
					instance.set_name(gen_unique_string())
					level.add_child(instance)
					instance.position.x += c.x*16 + current_offset*16
					instance.position.y += c.y*16
					instance.set_owner(level)
				else:
					tile_map.set_cellv(c+Vector2(current_offset,0), 0)
			current_offset+=healthspot.obtain_size().x
		else:
			var piece = pieces[randi() % pieces.size()]
			pieces.erase(piece)
			var temp = piece.instance()
			var tiles = temp.obtain_tiles()
			for j in tiles:
				var id = temp.obtain_tile_index(j)
				print(id)
				if id != 0:
					var object = load(convert_tile(id))
					var instance = object.instance()
					instance.set_name(gen_unique_string())
					level.add_child(instance)
					instance.position.x += j.x*16 + current_offset*16
					instance.position.y += j.y*16
					instance.set_owner(level)
				else:
					tile_map.set_cellv(j+Vector2(current_offset,0), 0)
			current_offset+=temp.obtain_size().x
	var ending = end_area.instance()
	var end_tiles = ending.obtain_tiles()
	for c in end_tiles:
		var id = ending.obtain_tile_index(c)
		print(id)
		if id != 0:
			var object = load(convert_tile(id))
			var instance = object.instance()
			instance.set_name(gen_unique_string())
			level.add_child(instance)
			instance.position.x += c.x*16 + current_offset*16
			instance.position.y += c.y*16
			instance.set_owner(level)
		else:
			tile_map.set_cellv(c+Vector2(current_offset,0), 0)
	current_offset+=ending.obtain_size().x
	tile_map.update_bitmask_region(Vector2(0,0),tile_map.get_used_rect().end)
	var touch_controls = mobile_controls.instance()
	level.add_child(touch_controls)
	touch_controls.set_owner(level)
	var packed_scene = PackedScene.new()
	var result = packed_scene.pack(level)
	if result == OK:
		var error = ResourceSaver.save(savepath, packed_scene)
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")
		else:
			print(levelname+" built.")

func convert_tile(tile_index):
	match tile_index:
		1:
			return "res://Scenes/Player.tscn"
		2:
			return "res://Scenes/Spikes.tscn"
		3:
			return "res://Scenes/LeftWallSpikes.tscn"
		4:
			return "res://Scenes/CeilingSpikes.tscn"
		5:
			return "res://Scenes/RightWallSpikes.tscn"
		6:
			return "res://Scenes/SpinningObstacle.tscn"
		7:
			return "res://Scenes/DeadlyArea.tscn"
		8:
			return "res://Scenes/LevelEnd.tscn"
		9:
			return "res://Scenes/PatrollingGroundEnemy.tscn"
		10:
			return "res://Scenes/JumpingPatrollingEnemy.tscn"
		11:
			return "res://Scenes/ChasingFlyingEnemy.tscn"
		12:
			return "res://Scenes/JumpingEnemy.tscn"
		13:
			return "res://Scenes/UnstompablePatrollingGroundEnemy.tscn"
		14:
			return "res://Scenes/FastJumpingEnemy.tscn"
		15:
			return "res://Scenes/UnslashablePatrollingGroundEnemy.tscn"
		16:
			return "res://Scenes/UnslashableJumpingEnemy.tscn"
		17:
			return "res://Scenes/UpTurret.tscn"
		18:
			return "res://Scenes/DownTurret.tscn"
		19:
			return "res://Scenes/LeftTurret.tscn"
		20:
			return "res://Scenes/RightTurret.tscn"
		21:
			return "res://Scenes/HealthPickUp.tscn"
		22:
			return "res://Scenes/UnstompableFlyingChasingEnemy.tscn"

func generate_game_files(game_name):
	print("copying game files...")
	var dir = Directory.new()
	var read_dir = Directory.new()
	dir.open("res://")
	dir.make_dir(game_name)
	dir.open("res://"+game_name)
	dir.make_dir("Scenes")
	dir.open("res://Scenes")
	dir.list_dir_begin()
	print("copying scenes...")
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
			#get_next() returns a string so this can be used to load the images into an array.
			print("copying "+file_name+"...")
			dir.copy("res://Scenes/" + file_name,"res://"+game_name+"/Scenes/"+file_name)
	dir.list_dir_end()
	dir.open("res://"+game_name)
	dir.make_dir("Scripts")
	dir.open("res://Scripts")
	dir.list_dir_begin()
	print("copying scripts...")
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
			#get_next() returns a string so this can be used to load the images into an array.
			print("copying "+file_name+"...")
			dir.copy("res://Scripts/" + file_name,"res://"+game_name+"/Scripts/"+file_name)
	dir.list_dir_end()
	dir.open("res://"+game_name)
	dir.make_dir("Assets")
	dir.open("res://Assets")
	dir.list_dir_begin()
	print("copying base assets...")
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
			#get_next() returns a string so this can be used to load the images into an array.
			print("copying "+file_name+"...")
			dir.copy("res://Assets/" + file_name,"res://"+game_name+"/Assets/"+file_name)
	dir.list_dir_end()
	print("copying other required files...")
	dir.copy("res://project.godot", "res://"+game_name+"/project.godot")
	dir.copy("res://default_bus_layout.tres", "res://"+game_name+"/default_bus_layout.tres")
	dir.copy("res://default_env.tres", "res://"+game_name+"/default_env.tres")
	dir.copy("res://icon.png", "res://"+game_name+"/icon.png")
	dir.copy("res://Assets/TileSet.tres", "res://"+game_name+"/Assets/TileSet.tres")
	dir.copy("res://Assets/tileset.png", "res://"+game_name+"/Assets/tileset.png")
	dir.open("res://"+game_name+"/Scenes")
	dir.make_dir("Levels")
	print("building levels...")
	var start = 1
	while start <= 30:
		create_level("Level"+str(start), tileset,tilemap,"res://"+game_name+"/Scenes/Levels/Level"+str(start)+".tscn")
		start += 1
	print("done.")
