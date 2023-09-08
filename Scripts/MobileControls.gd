extends CanvasLayer

var menu_path = "res://Scenes/MainMenu.tscn"

func _ready():
	resume()
	set_audio_buttons_text()


func _on_Pause_pressed():
	pause()

func pause():
	get_tree().paused = true
	$Background.visible = true
	$MenuButtons.visible = true
	$TouchButtons.visible = false

func _on_ContinueButton_pressed():
	resume()

#func set_visible(value):
#	$Background.visible = value
#


func _on_QuitButton_pressed():
	get_tree().paused = false
	$Background.visible = false
	$MenuButtons.visible = false
	SceneChanger.change_scene(menu_path)


func resume():
	get_tree().paused = false
	$Background.visible = false
	$MenuButtons.visible = false
	$TouchButtons.visible = true

func set_audio_buttons_text():
	if SoundSystem.is_sound_muted():
		$MenuButtons/VBoxContainer/SoundButton.text = "Sound: OFF"
	else:
		$MenuButtons/VBoxContainer/SoundButton.text = "Sound: ON"

	if SoundSystem.is_music_muted():
			$MenuButtons/VBoxContainer/MusicButton.text = "Music: OFF"
	else:
		$MenuButtons/VBoxContainer/MusicButton.text = "Music: ON"

func _on_SoundButton_pressed():
	if SoundSystem.is_sound_muted():
		SoundSystem.unmute_sound()
	else:
		SoundSystem.mute_sound()
	set_audio_buttons_text()

func _on_MusicButton_pressed():
	if SoundSystem.is_music_muted():
		SoundSystem.unmute_music()
	else:
		SoundSystem.mute_music()
	set_audio_buttons_text()
