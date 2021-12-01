extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var start_pos = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var spd = 5
var xspd = 0
var caught = false
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	start_pos = Vector2(global_position.x,  global_position.y + rng.randi_range(-23, 20))
	spd = rng.randi_range(-3, 5)
	


func _physics_process(delta):
	xspd = rng.randi_range(-2, 2)
	self.global_position.x -= 7.3 + spd - delta
	self.global_position.y -= xspd
	
	
	if self.global_position.x < 8 or caught:
		rng.randomize()
		start_pos = Vector2(start_pos.x,  start_pos.y + rng.randi_range(-24, 22))
		global_position = start_pos
		spd = rng.randi_range(-3, 5)
		caught = false
