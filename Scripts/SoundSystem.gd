extends Node

var music_bus = AudioServer.get_bus_index("Music")
var sound_bus = AudioServer.get_bus_index("Sound")

var game_music = load("res://Assets/game-music.mp3")
var menu_music = load("res://Assets/menu-music.mp3")

onready var menu_music_player = $MenuMusic
onready var game_music_player = $GameMusic

func mute_sound():
	AudioServer.set_bus_mute(sound_bus,true)

func unmute_sound():
	AudioServer.set_bus_mute(sound_bus,false)

func mute_music():
	AudioServer.set_bus_mute(music_bus,true)

func unmute_music():
	AudioServer.set_bus_mute(music_bus,false)

func is_sound_muted():
	return AudioServer.is_bus_mute(sound_bus)

func is_music_muted():
	return AudioServer.is_bus_mute(music_bus)

func play_game_music():
	menu_music_player.stop()
	if !game_music_player.is_playing():
		game_music_player.play()

func play_menu_music():
	game_music_player.stop()
	if !menu_music_player.is_playing():
		menu_music_player.play()
