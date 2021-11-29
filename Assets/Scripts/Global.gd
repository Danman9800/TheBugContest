extends Node


var time = 60
var over = false
var multi_player = false
var audio_on = true
var music_on = true
var start_bg_music_pos = 0

var player1_won = false
var player2_won = false
var caught1 = 0
var caught2 = 0
var player1_ded = false
var player2_ded = false
var Score = 0
var highScore = 0

func saveGame():
	var file = File.new()
	file.open_encrypted_with_pass("res://score.txt", File.WRITE, "enc325")
	file.store_string(String(Score))
	file.close()

func loadGame():
	var file = File.new()
	file.open_encrypted_with_pass("res://score.txt", File.READ_WRITE, "enc325")
	highScore = int(file.get_as_text())
	file.close()
