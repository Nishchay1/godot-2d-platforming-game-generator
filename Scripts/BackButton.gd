extends Button

var main_path = "res://Scenes/MainMenu.tscn"


func _on_BackButton_pressed():
	SceneChanger.change_scene(main_path)
