extends Node2D

onready var spinbase = $SpinBase

var rotation_speed = 4

func _physics_process(delta):
	spinbase.rotation+=rotation_speed*delta

