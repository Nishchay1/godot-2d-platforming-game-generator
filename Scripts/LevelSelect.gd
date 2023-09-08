extends Control

export (PackedScene) var base_button

onready var grid = $Divider/CenterButtons/ButtonGrid


func _ready():
	var max_level = SaveSystem.load_level()
	print(max_level)
	grid.columns = 6
	for i in range(0, max_level[0]):
		generate_buttons(i + 1, false)
	for i in range(max_level[0], 30):
		generate_buttons(i + 1, true)
	SoundSystem.play_menu_music()


func generate_buttons(level : int, locked : bool):
	var bb = base_button.instance()
	grid.add_child(bb)
	bb.set_locked(locked)
	if !locked:
		bb.set_text(str(level))
		bb.set_level(level)
	bb.level_path = ("res://Scenes/Levels/Level" + str(level) + ".tscn")
