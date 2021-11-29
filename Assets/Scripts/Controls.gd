extends Control

func _process(delta):
	
	if $Return/Button.pressed:
		visible = false
		
	
		
	if $Return/Button.is_hovered():
		$Return.add_color_override("font_color", Color(.5, .5, .5, 1))
	else:
		$Return.add_color_override("font_color", Color(1, 1, 1, 1))
	
	
	
