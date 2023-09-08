extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

func _ready():
	pass

func save_level(max_level:int, increment:bool):
	var data = [max_level, increment]
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
		var first = File.new()
		var error = first.open(save_path, File.WRITE)
		var default = [1,false]
		if error == OK:
			first.store_var(default)
			first.close()
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()

func load_level():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var value = file.get_var()
			file.close()
			return value
	else:
		return [1,false]
