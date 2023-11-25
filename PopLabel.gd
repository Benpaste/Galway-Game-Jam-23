extends Label

var value := 0
var foragers := 0

func _physics_process(delta):
	text = "Population Size: %s Ants (%s idle, %s out)" % [value, value-foragers, foragers]
