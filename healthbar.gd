extends Control

var MAX := 100
var value := 50

func _physics_process(delta):
	$ProgressBar.max_value = MAX
	$ProgressBar.value = value
	$ProgressBar/Value.text = "%s/%s" % [int(value),int(MAX)]

func set_stats(v: float, m: float):
	MAX = m
	value = v
