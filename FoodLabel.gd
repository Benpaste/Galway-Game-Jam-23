extends Label

func _physics_process(delta):
	text = "Stored Food: %smg" % round(get_node("/root/Main").stored_food)
