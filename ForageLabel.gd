extends Label

var dots = 0
enum FORAGING {IDLE, LEAVE, RETURN, RETURN_DONE, FOUND,
KILLING, KILLING_DONE,
EATING, EATING_DONE,
INVEST, INVEST_DONE,
TOO_HEAVY_TO_KILL, TOO_HEAVY_TO_CARRY, DEAD, GAMEOVER}
var state = 0

func _on_tick_timer_timeout():
	
	match state:
		FORAGING.LEAVE:
			text = "Currently foraging"
		FORAGING.FOUND:
			text = "Found food."
		FORAGING.INVEST:
			text = "Identifying food"
		FORAGING.INVEST_DONE:
			text = "It's a %smg %s! " % [round(%Food.my_weight), %Food.type]
			if %Food.my_alive: text += "It's alive!"
			else: text += "It's dead."
		FORAGING.KILLING:
			text = "Killing the %s" % %Food.type
		FORAGING.KILLING_DONE:
			text = "Killed the %s!" % %Food.type
		FORAGING.EATING:
			text = "Foragers eating %s" % %Food.type
		FORAGING.EATING_DONE:
			text = "Foragers ate some %s." % %Food.type
			if %Food.my_weight <= 5:
				text = "Foragers ate all the %s." % %Food.type
		FORAGING.RETURN:
			if %Food.get_null():
				text = "Returning empty-handed"
			else:
				text = "Carrying the %s home" % %Food.type
		FORAGING.RETURN_DONE:
			if %Food.get_null():
				text = "Returned."
			else:
				text = "Returned with %s!" % %Food.type
		FORAGING.TOO_HEAVY_TO_CARRY:
			text = "It's too heavy to carry."
		FORAGING.TOO_HEAVY_TO_KILL:
			text = "It's too big to kill."
		FORAGING.DEAD:
			text = "All foragers died..."
		FORAGING.GAMEOVER:
			text = "QUEEN STARVED. GAME OVER"
		
		
	if text != "":
		if !(text[-1] in ["!","."]):
			dots += 1
			dots %= 4
			for i in dots: text += "."
