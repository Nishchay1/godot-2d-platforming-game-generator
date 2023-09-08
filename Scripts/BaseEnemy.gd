extends KinematicBody2D

var death_effect = preload("res://Scenes/DeathEffect.tscn")
var death_sound = preload("res://Scenes/EnemyDeathSound.tscn")

func destroy():
	var effect = death_effect.instance()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)
	var sound = death_sound.instance()
	sound.global_position = global_position
	get_tree().current_scene.add_child(sound)
	queue_free()
