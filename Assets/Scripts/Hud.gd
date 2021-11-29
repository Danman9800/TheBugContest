extends Control



func _ready():
	if Global.multi_player or Global.over:
		Global.over = false
		Global.time = 60
	$Player2.visible = Global.multi_player
	if !Global.multi_player:
		$Player1.rect_global_position.x = 198
	else:
		$Player1.rect_global_position.x = 966
	$TimerText.text = String(Global.time)
	$Player1/Player1Score.text = String(Global.caught1)
	$Player2/Player2Score.text = String(Global.caught2)
	$Timer.set_wait_time(1.0)
	$Timer.start()

func _process(delta):
	$Player2.visible = Global.multi_player
	$Player1/Player1Score.text = String(Global.caught1)
	$Player2/Player2Score.text = String(Global.caught2)
	
	if !Global.multi_player:
		$Player1.rect_global_position.x = 198
	else:
		$Player1.rect_global_position.x = 966
		
	

func _on_Timer_timeout():
	if Global.time <= 1:
		$Timer.stop()
		Global.over = true
		get_tree().change_scene("res://Assets/Scenes/LooseScreen.tscn")
	else:
		Global.time -=1
		$TimerText.text = String(Global.time)
