extends Node

@onready var musicPlayer: AudioStreamPlayer = $MusicPlayer
@onready var sfxPlayer: AudioStreamPlayer = $SFXPlayer

const MUSIC = {
	"main_menu" : preload("res://Assets/Audio/Music/[SNES Music] Super Mario World - Donut Plains (Map Theme 2) - Plokfan.mp3"),
	"char_select" : preload("res://Assets/Audio/Music/Select Screen - Mario Kart 64 OST - Neutri Bros..mp3"),
	"phase1" : preload("res://Assets/Audio/Music/Kirby's Adventure (NES) Music - Ice Cream Island 2 no Intro - GBelair.mp3"),
	"phase2" : preload("res://Assets/Audio/Music/Super Mario Kart Music (SNES) - Donut Plains - Rolf Cole.mp3"),
}

const SFX = {
	"button" : preload("res://Assets/Audio/SFX/SoundEffect.mp3"),
}

func play_music(key: String) -> void:
	if not MUSIC.has(key):
		return
	if musicPlayer.stream == MUSIC[key] and musicPlayer.playing:
		return
	musicPlayer.stream = MUSIC[key]
	musicPlayer.play()

func stop_music() -> void:
	musicPlayer.stop()

func play_sfx(key: String) -> void:
	if not SFX.has(key):
		return
	sfxPlayer.stream = SFX[key]
	sfxPlayer.play()
