extends Path2D

@export var ANT : PackedScene

func create_ants(out: bool, many: int):
	for i in many:
		var myant = ANT.instantiate()
		myant.dir = out
		add_child(myant)
		await get_tree().create_timer(0.2).timeout
		
