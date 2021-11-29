extends Control



var selected_sp = false
var selected_mp = false
var played = false
func _ready():
	$Music.seek(Global.start_bg_music_pos)
	selected_sp = false
	selected_mp = false
	if Global.audio_on:
		$AudioOff.play("On")
		$Blip.stream = load("res://Assets/Sfx/Select.wav")
		$Select.stream = load("res://Assets/Sfx/Select.wav")
	
	else:
		$AudioOff.play("Off")
		$Blip.stream = load("res://Assets/Sfx/Empty.wav")
		$Select.stream = load("res://Assets/Sfx/Empty.wav")
	
	if Global.music_on:
		$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOn.png")
		if Global.start_bg_music_pos == 0:
			$Music.stream = load("res://Assets/Music/woods.wav")
			$Music.play()
		
		
	
	else:
		$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOff.png")
		$Music.stream = load("res://Assets/Sfx/Empty.wav")
	
	
func _process(delta):

		
	if $"Multi-player/Button".pressed:
		Global.multi_player = true
		#$Desc.rect_global_position.x = 100
		$Desc.text = "Play with another preson on same keyboard."
		$Start.visible = true
		if !$Select.playing:
			$Select.play()
		$"Single-Player/ReferenceRect".border_color = Color(0.2, 0.15, 0.15, 1)
		selected_mp = true
		selected_sp = false
		
		
	elif $"Single-Player/Button".pressed:
		Global.multi_player = false
		$Start.visible = true
		if !$Select.playing:
			$Select.play()
		$"Multi-player/ReferenceRect".border_color = Color(0.2, 0.15, 0.15, 1)
		$Desc.text = "Play alone."
		selected_sp = true
		selected_mp = false
	
		
	if $Start/Button.pressed:
		Global.caught1 = 0
		Global.caught2 = 0
		Global.time = 60
		
		if !$Blip.playing:
			$Blip.play()
			
	if $Information/Button.pressed:
		$Info.visible = true
	if $Gamepad/Button.pressed:
		$Controls.visible = true
	
	if $Start/Button.is_hovered():
		$Start.add_color_override("font_color", Color(.5, .5, .5, 1))
		$Start/Forward.modulate = Color(.5, .5, .5, 1)
	else:
		
		$Start.add_color_override("font_color", Color(1, 1, 1, 1))
		$Start/Forward.modulate = Color(1, 1, 1, 1)
		
	if $"Multi-player/Button".is_hovered():
		$"Multi-player/ReferenceRect".border_color = Color(0.8, 0.35, 0.35, 1)
	else:
		if !selected_mp:
			$"Multi-player/ReferenceRect".border_color = Color(0.2, 0.15, 0.15, 1)
			
	
	if $"Single-Player/Button".is_hovered():
		$"Single-Player/ReferenceRect".border_color = Color(0.8, 0.35, 0.35, 1)
	else:
		if !selected_sp:
			$"Single-Player/ReferenceRect".border_color = Color(0.2, 0.15, 0.15, 1)
	
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
		
	if $AudioOff/Button.pressed and Input.is_action_just_pressed("LMB"):
		if !$Select.playing:
			$Select.play()
		if Global.audio_on == true:
			
			$AudioOff.play("Off")
			Global.audio_on = false
		else:
			$AudioOff.play("On")
			Global.audio_on = true
		if Global.audio_on:
			$Blip.stream = load("res://Assets/Sfx/Select.wav")
			$Select.stream = load("res://Assets/Sfx/Select.wav")
		else:
			$Blip.stream = load("res://Assets/Sfx/Empty.wav")
			$Select.stream = load("res://Assets/Sfx/Empty.wav")
	
	if $MusicOff/Button.pressed and Input.is_action_just_pressed("LMB"):
		
		if Global.music_on == true:
			
			$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOff.png")
			Global.music_on = false
		else:
			$MusicOff.texture = load("res://Assets/Sprites/Ui/musicOn.png")
			Global.music_on = true
		
		if Global.music_on:
			$Music.stream = load("res://Assets/Music/woods.wav")
			$Music.play()
			
		else:
			$Music.stream = load("res://Assets/Sfx/Empty.wav")


func _on_Blip_finished():
	Global.start_bg_music_pos = $Music.get_playback_position()
	get_tree().change_scene("res://Assets/Scenes/Map1.tscn")
