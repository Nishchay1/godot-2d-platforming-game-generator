extends Area2D

onready var animation_player = $AnimationPlayer


func attack():
	if !animation_player.is_playing():
		animation_player.play("slash")

