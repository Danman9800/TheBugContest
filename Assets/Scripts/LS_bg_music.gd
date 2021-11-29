extends AudioStreamPlayer


func _ready():
	yield(get_tree().create_timer(.25), "timeout")
	play()
