extends Node2D

export var multi_player = false
export var debug = false
func _ready():
	#$Music.seek(Global.start_bg_music_pos)
	if debug:
		Global.multi_player = multi_player
	if Global.audio_on == true:
	
		$AudioOff.play("On")
		
	else:
		$AudioOff.play("Off")
	
	if Global.music_on:
		$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOn.png")

	
	else:
		$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOff.png")
		$Music.stream = load("res://Assets/Sfx/Empty.wav")
		


func _process(delta):
	if debug:
		Global.multi_player = multi_player
		
	if Global.caught1 > Global.caught2:
		Global.player2_won = false
		Global.player1_won = true
	elif Global.caught2 > Global.caught1:
		Global.player1_won = false
		Global.player2_won = true
	elif Global.caught1 == Global.caught2:
		Global.player1_won = false
		Global.player2_won = false
		
	if $AudioOff/Button.pressed and Input.is_action_just_pressed("LMB"):
		
		if Global.audio_on == true:
		
			$AudioOff.play("Off")
			Global.audio_on = false
		else:
			$AudioOff.play("On")
			Global.audio_on = true
	
	if $MusicOff/Button.pressed and Input.is_action_just_pressed("LMB"):
		
		if Global.music_on == true:
			
			$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOff.png")
			Global.music_on = false
		else:
			$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOn.png")
			Global.music_on = true
		
		if Global.music_on:
			$Music.stream = load("res://Assets/Music/2019-12-11_-_Retro_Platforming_-_David_Fesliyan.mp3")
			$Music.play()
			
		else:
			$Music.stream = load("res://Assets/Sfx/Empty.wav")
		


	
	
	if $AudioOff/Button.is_hovered():
		$AudioOff/Text.visible = true
	else:
		$AudioOff/Text.visible = false
	
	
	if $MusicOff/Button.is_hovered():
		$MusicOff/Text.visible = true
	else:
		$MusicOff/Text.visible = false
	

		


func _on_Player1_dead():
	Global.start_bg_music_pos = $Music.get_playback_position()


func _on_Player2_dead():
	Global.start_bg_music_pos = $Music.get_playback_position()
