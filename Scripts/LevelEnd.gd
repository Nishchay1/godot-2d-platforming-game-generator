extends Area2D

onready var finished_scene

func _ready():
	finished_scene = "res://Scenes/LevelSelect.tscn"

func _on_LevelEnd_body_entered(body):
	if body.is_in_group("player"):
		var data = SaveSystem.load_level()
		if data[1]:
			if data[0]<30:
				SaveSystem.save_level(data[0]+1,false)
		SceneChanger.change_scene(finished_scene)
