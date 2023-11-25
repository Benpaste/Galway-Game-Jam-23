extends Node
class_name Ant



enum {
	STATE_IDLE,
	STATE_LEAVE,
	STATE_RETURN,
}


var age = 0
var MAX_HEALTH = 25
var health = 1
var state = STATE_IDLE

func _ready():
	health = MAX_HEALTH


var rate = 0.5
func do_frame():
	age += 1
	health -= abs(randf_range(0, 2*rate))
	
	if health <= 0:
		die()

func die():
	NewsHandler.broadcast("An ant just died...")
	queue_free()


func set_state(s: int):
	state = s
