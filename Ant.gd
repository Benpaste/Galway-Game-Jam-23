extends Node
class_name Ant

enum {
	STATE_IDLE,
	STATE_LEAVE,
	STATE_RETURN,
}

var MAX_HEALTH = 1000
var health = 1
var state = STATE_IDLE

func _ready():
	health = MAX_HEALTH


var rate = 10
var variability = 10
func do_frame():
	health -= abs(randf_range(rate-variability, rate+variability))
	
	if health <= 0:
		die()

signal ant_died
func die():
	ant_died.emit()
	queue_free()


func set_state(s: int):
	state = s
