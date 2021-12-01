extends Node2D

var start_position = Vector2(0,0)
export var speed = 1
export var x_sp = .01
var rng = RandomNumberGenerator.new()
func _ready():
	speed = .5
	start_position = global_position
	rng.randomize()
	speed += rng.randi_range(-.1, .1)
	x_sp += rng.randf_range(-.04, .04)
	
func _process(delta):
	
	global_position.y += speed / 1.9 
	global_position.x += x_sp
	if global_position.y > 980 or global_position.x < 0 or global_position.x > 1218:
		speed = .5
		global_position = start_position
		rng.randomize()
		speed += rng.randi_range(-.1, .1)
		x_sp += rng.randf_range(-.04, .04)
		
