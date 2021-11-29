extends KinematicBody2D

export var enabled = true
var mvdir = 0
var xSpeed = 250
var velocity = Vector2(0,0)
var start_pos = Vector2(0,720)
var ded = false
signal dead
func _ready():
	if enabled:
		ded = false
		start_pos = Vector2(global_position.x, 720)
		if Global.audio_on:
			$Jump.stream = load("res://Assets/Sfx/Jump.wav")
			$Gotcha.stream = load("res://Assets/Sfx/Gotcha.wav")
			$Hurt.stream = load("res://Assets/Sfx/Hurt.wav")
		else:
			$Jump.stream = load("res://Assets/Sfx/Empty.wav")
			$Gotcha.stream = load("res://Assets/Sfx/Empty.wav")
			$Hurt.stream = load("res://Assets/Sfx/Empty.wav")
	else:
		$Collider.disabled = true
		visible = false

func _physics_process(delta):
	enabled = Global.multi_player
	if enabled:
		
		action()
		if !is_on_floor():
			
			velocity.y +=25
		else:
			velocity.x = xSpeed * mvdir 
			velocity.y = 0
		if Input.is_action_pressed("p2_jump") and is_on_floor():
			$Jump.play()
			velocity.y -= 440
		Global.player2_ded = ded
			
		if Global.multi_player and !Global.player1_ded: 
			if ded:
				self.queue_free()
		if Input.is_action_pressed("LMB"):
		
			if Global.audio_on:
				$Jump.stream = load("res://Assets/Sfx/Jump.wav")
				$Gotcha.stream = load("res://Assets/Sfx/Gotcha.wav")
				$Hurt.stream = load("res://Assets/Sfx/Hurt.wav")
			else:
				$Jump.stream = load("res://Assets/Sfx/Empty.wav")
				$Gotcha.stream = load("res://Assets/Sfx/Empty.wav")
				$Hurt.stream = load("res://Assets/Sfx/Empty.wav")
				
			
	else:
		$Collider.disabled = true
		visible = false
	
		
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if global_position.y > 960: 
		global_position = start_pos
		Global.caught2 -= 1
		Global.caught2 = clamp(Global.caught2, 0.0, 100000000.0)
	
func action():
	if mvdir == -1:
		$Sprite.flip_h = 1
		$Sprite.animation = "walk"
	elif mvdir == 1:
		$Sprite.flip_h = 0
		$Sprite.animation = "walk"
	else:
		$Sprite.animation = "idle"
	
	mvdir = Input.get_action_strength("p2_right") - Input.get_action_strength("p2_left")
	
	
	


func _on_Net_body_entered(body):
	if body.is_in_group("Bug"):
		body.queue_free()


func _on_Net_area_entered(area):
	if enabled:
		if area.global_position.x > $Catchpos.global_position.x and area.is_in_group("Bug"):
			$Gotcha.play()
			area.caught = true
			Global.caught2 += 1
	else:
		$Collider.disabled = true
		visible = false


func _on_Hitbox_area_entered(area):
	if enabled:
		if area.is_in_group("Bug"):
			
			
			$Hurt.play()

				
			
	else:
		$Collider.disabled = true
		visible = false


func _on_Hurt_finished():
	ded = true
	if !Global.multi_player or Global.player1_ded:
		emit_signal("dead")
		get_tree().change_scene("res://Assets/Scenes/LooseScreen.tscn")
