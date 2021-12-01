extends Node2D

var start_position = Vector2(0,0)
export var speed = 60
export var x_sp = .01
var rng = RandomNumberGenerator.new()
func _ready():
	speed = 100
	start_position = global_position
	rng.randomize()
	speed += rng.randi_range(-50, 0)
	x_sp += rng.randf_range(-.04, .04)
func _process(delta):
	
	global_position.y += speed * delta
	global_position.x += x_sp
	if global_position.y > 980 or global_position.x < 0 or global_position.x > 1218:
		speed = 100
		global_position = start_position
		rng.randomize()
		speed += rng.randi_range(-50, 0)
		x_sp += rng.randf_range(-.04, .04)
	
