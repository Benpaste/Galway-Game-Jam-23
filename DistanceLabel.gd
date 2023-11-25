extends Label

var value = 0

func _physics_process(delta):
	text = "Distance from nest: %scm" % value
