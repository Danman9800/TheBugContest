extends Control


var music_on = true

 




func _ready():
	
	$Music.seek(Global.start_bg_music_pos)
	
	$AnimationPlayer.play("Start_Fade")
	if Global.audio_on:
		$AudioOff.play("On")
		$Blip.stream = load("res://Assets/Sfx/Select.wav")
	
	else:
		$AudioOff.play("Off")
		$Blip.stream = load("res://Assets/Sfx/Empty.wav")
	
	if Global.music_on:
		$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOn.png")
		if Global.start_bg_music_pos == 0:
			$Music.stream = load("res://Assets/Music/2021-10-19_-_Funny_Bit_-_www.FesliyanStudios.com.mp3")
			$Music.play()
	
	else:
		$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOff.png")
		$Music.stream = load("res://Assets/Sfx/Empty.wav")
	
	Global.loadGame()
	
	
func _process(delta):

	$highScore.text = String(Global.highScore)
	if $Start/Button.pressed:
		Global.caught1 = 0
		Global.caught2 = 0
		Global.time = 60
		
		if !$Blip.playing:
			$Blip.play()
		
	
	if $Start/Button.is_hovered():
		$Start.add_color_override("font_color", Color(.5, .5, .5, 1))
	else:
		$Start.add_color_override("font_color", Color(1, 1, 1, 1))
		
	
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
	
	if $Information/Button.pressed:
		$Info.visible = true
	if $Gamepad/Button.pressed:
		$Controls.visible = true

	
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
			
			$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOff.png")
			Global.music_on = false
		else:
			$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOn.png")
			Global.music_on = true
		
		if Global.music_on:
			$Music.stream = load("res://Assets/Music/2021-10-19_-_Funny_Bit_-_www.FesliyanStudios.com.mp3")
			$Music.play()
			
		else:
			$Music.stream = load("res://Assets/Sfx/Empty.wav")
			
	
			
	
	
	
	

	


func _on_Blip_finished():
	Global.start_bg_music_pos = $Music.get_playback_position()
	get_tree().change_scene("res://Assets/Scenes/Mode.tscn")
