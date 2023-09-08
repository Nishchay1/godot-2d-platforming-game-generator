extends Button

var locked = true setget set_locked

var level_path : String

var level : int


func set_locked(value):
	locked = value
	set_lock_visible()

func set_level(value):
	level = value

func _on_Button_pressed():
	if !locked:
		var data = SaveSystem.load_level()
		if data[0]>level:
			SaveSystem.save_level(data[0],false)
		if data[0]==level:
			SaveSystem.save_level(data[0],true)
		SceneChanger.change_scene(level_path)

func set_lock_visible():
	if locked:
		$lock.visible=true
	else:
		$lock.visible=false
