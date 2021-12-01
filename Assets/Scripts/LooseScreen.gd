extends Control

# 558

func _ready():
	$Music.seek(Global.start_bg_music_pos)
	$Player2.visible = Global.multi_player
	$Player1/Player1Score.text = String(Global.caught1)
	$Player2/Player2Score.text = String(Global.caught2)
	if Global.over:
		$Retry.text = "Time Over"
	else:
		$Retry.text = "Retry"
	if !Global.multi_player:
		$Player1.rect_global_position.x = 558
		Global.Score = Global.caught1
		if Global.Score > Global.highScore:
			Global.saveGame()
		$Crown.visible = false
	else:
		$Player1.rect_global_position.x = 666
	
	if Global.player1_won and Global.multi_player:
		$Crown.rect_global_position.x = 666
		Global.Score = Global.caught1
		if Global.Score > Global.highScore:
			Global.saveGame()
	elif Global.player2_won and Global.multi_player:
		$Crown.rect_global_position.x = 420
		Global.Score = Global.caught2
		if Global.Score > Global.highScore:
			Global.saveGame()
	else:
		$Crown.visible = false
	
	if Global.audio_on:
		$AudioOff.play("On")
		$Blip.stream = load("res://Assets/Sfx/Select.wav")
	
	else:
		$AudioOff.play("Off")
		$Blip.stream = load("res://Assets/Sfx/Empty.wav")
	
	if Global.music_on:
		$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOn.png")

	
	else:
		$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOff.png")
		$Music.stream = load("res://Assets/Sfx/Empty.wav")
	
		

func _process(delta):
	
	
	if $Ok/Button.pressed:
		Global.caught1 = 0
		Global.caught2 = 0
		Global.time = 60
		if !$Blip.playing:
			$Blip.play()
	
	if $Gamepad/Button.is_hovered():
		$Gamepad/Text.visible = true
	else:
		$Gamepad/Text.visible = false
	
	
	if $AudioOff/Button.is_hovered():
		$AudioOff/Text.visible = true
	else:
		$AudioOff/Text.visible = false
	
	
	if $MusicOff/Button.is_hovered():
		$MusicOff/Text.visible = true
	else:
		$MusicOff/Text.visible = false
	
	if $Information/Button.is_hovered():
		$Information/Text.visible = true
	else:
		$Information/Text.visible = false
		
	
	if $Ok/Button.is_hovered():
		$Ok.add_color_override("font_color", Color(.5, .5, .5, 1))
	else:
		$Ok.add_color_override("font_color", Color(1, 1, 1, 1))
	
	if $AudioOff/Button.pressed and Input.is_action_just_pressed("LMB"):

		if Global.audio_on == true:
			
			$AudioOff.play("Off")
			Global.audio_on = false
		else:
			$AudioOff.play("On")
			Global.audio_on = true
		if Global.audio_on:
			$Blip.stream = load("res://Assets/Sfx/Select.wav")
			
		else:
			$Blip.stream = load("res://Assets/Sfx/Empty.wav")
	if $MusicOff/Button.pressed and Input.is_action_just_pressed("LMB"):
		
		if Global.music_on == true:
			Global.start_bg_music_pos = $Music.get_playback_position()
			$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOff.png")
			Global.music_on = false
		else:
			$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOn.png")
			Global.music_on = true
		
		if Global.music_on:
			$Music.stream = load("res://Assets/Music/2019-12-11_-_Retro_Platforming_-_David_Fesliyan.mp3")
			$Music.play()
			$Music.seek(Global.start_bg_music_pos)
			
		else:
			$Music.stream = load("res://Assets/Sfx/Empty.wav")
	if $Information/Button.pressed:
		$Info.visible = true
	if $Gamepad/Button.pressed:
		$Controls.visible = true
		
	


func _on_Blip_finished():
	Global.start_bg_music_pos = 0
	get_tree().change_scene("res://Assets/Scenes/Start.tscn")
