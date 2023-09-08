extends Control


func _ready():
	set_audio_buttons_text()
	SoundSystem.play_menu_music()

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
