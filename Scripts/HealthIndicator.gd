extends CanvasLayer

onready var health_one = $HealthSymbols/Health1
onready var health_two = $HealthSymbols/Health2
onready var health_three = $HealthSymbols/Health3

func update_health_indicator(value):
	match value:
		0:
			health_one.visible=false
			health_two.visible=false
			health_three.visible=false
		1:
			health_one.visible=true
			health_two.visible=false
			health_three.visible=false
		2:
			health_one.visible=true
			health_two.visible=true
			health_three.visible=false
		3:
			health_one.visible=true
			health_two.visible=true
			health_three.visible=true
