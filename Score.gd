extends Node

var record = 0
var score = 0


func update_score():
	score += 1
	if record < score:
		record = score
