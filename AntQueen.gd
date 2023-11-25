extends Ant
class_name AntQueen

func _init():
	MAX_HEALTH = 70

signal gameover(i: int)
func die():
	gameover.emit(age)
