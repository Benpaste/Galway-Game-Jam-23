extends Label

var dots = 0
enum FORAGING {IDLE, LEAVE, RETURN, FOUND,
EATING, EATING_DONE,
INVEST, INVEST_DONE}
var state = 0

func _on_tick_timer_timeout():
	
	match state:
		FORAGING.LEAVE:
			text = "%s currently foraging" % get_node("/root/Main").foragers
		FORAGING.FOUND:
			text = "Found some food!"
		FORAGING.INVEST:
			text = "Identifying food"
		FORAGING.INVEST_DONE:
			text = "It's a %s! " % %Food.type
			if %Food.my_alive: text += "It's alive!"
			else: text += "It's dead!"
	
	if !text.ends_with("!"):
		dots += 1
		dots %= 4
		for i in dots: text += "."
