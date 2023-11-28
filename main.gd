extends Node2D

const STARTING_ANTS = 6

var foragers = 0
var time_to_change = 0

var stored_food = 50

enum WEATHER {CLEAR, RAIN, WIND}
var weather = WEATHER.CLEAR


enum FORAGING {IDLE, LEAVE, RETURN, RETURN_DONE, FOUND,
KILLING, KILLING_DONE,
EATING, EATING_DONE,
INVEST, INVEST_DONE,
TOO_HEAVY_TO_KILL, TOO_HEAVY_TO_CARRY, DEAD, GAMEOVER}
var foraging = FORAGING.IDLE

var distance_from_nest = 0

func _ready():
	for i in STARTING_ANTS:
		var new_ant = Ant.new()
		%Ants.add_child(new_ant)


func _physics_process(delta):
	
	var pop_health = get_pop_health()
	%HealthbarPop.set_stats(pop_health[0],pop_health[1])
	%HealthbarQueen.set_stats(%AntQueen.health, %AntQueen.MAX_HEALTH)
	%PopLabel.value = get_pop_size()
	%PopLabel.foragers = get_foragers().size()
	%DialogLabel.text = "Send %s to forage?" % foragers
	if foraging == FORAGING.IDLE:
		set_foragers(foragers)


func get_pop_size():
	return %Ants.get_child_count() - 1


func get_foragers() -> Array:
	return get_tree().get_nodes_in_group("Foragers")


func get_pop_health():
	
	var MAX_HEALTH = 0
	var health = 0
	
	for i in %Ants.get_children():
		if i != %AntQueen:
			MAX_HEALTH += i.MAX_HEALTH
			health += i.health
	
	return [health, MAX_HEALTH]


func do_tick():
	if foraging != FORAGING.GAMEOVER:
		Score.update_score()
		%CurrentScoreLabel.text = "Score: %shr" % Score.score
		%HiScoreLabel.text = "Record: %shr" % Score.record
	else:
		return
	
	
	for i in %Ants.get_children():
		i.do_frame()
		
		if not i in get_foragers():
			if stored_food > 0 and i.health < i.MAX_HEALTH-1:
				NewsHandler.broadcast("Nest eating well!")
				stored_food -= 1
				i.health += 1
		else:
			if foraging == FORAGING.EATING:
				if %Food.my_weight >= 5 and i.health < i.MAX_HEALTH-1:
					NewsHandler.broadcast("Foragers eating!")
					%Food.my_weight -= 5
					i.health += 5
		stored_food = max(0, stored_food)
	
	time_to_change -= 1
	
	if foraging in [FORAGING.IDLE, FORAGING.GAMEOVER]:
		%DistanceLabel.hide()
	else:
		%DistanceLabel.show()
		if get_foragers().size() == 0:
			set_foraging(FORAGING.DEAD)
	
	match foraging:
		FORAGING.LEAVE:
			forage_for_food()
			distance_from_nest += 1
			%DistanceLabel.value = distance_from_nest
		FORAGING.INVEST:
			if time_to_change <= 0:
				set_foraging(FORAGING.INVEST_DONE)
		FORAGING.EATING:
			if time_to_change <= 0:
				set_foraging(FORAGING.EATING_DONE)
		FORAGING.RETURN:
			if time_to_change <= 0:
				set_foraging(FORAGING.RETURN_DONE)
			else:
				distance_from_nest = 4*time_to_change
				%DistanceLabel.value = distance_from_nest


func _on_button_plus_button_down():
	set_foragers(foragers + 1)


func _on_button_minus_button_down():
	set_foragers(foragers - 1)


func set_foragers(f: int):
	foragers = max(0, min(get_pop_size(), f))


func get_idle_ants():
	var out = []
	for i in %Ants.get_children():
		if i != %AntQueen:
			if i.state == i.STATE_IDLE:
				out.append(i)
	return out


func _on_button_ok_button_down():
	match foraging:
		FORAGING.IDLE:
			distance_from_nest = 0
			send_foragers()
		FORAGING.FOUND:
			set_foraging(FORAGING.INVEST)
		FORAGING.INVEST_DONE:
			
			if %Food.my_alive:
				if %Food.my_weight > foragers * 10:
					set_foraging(FORAGING.TOO_HEAVY_TO_KILL)
				else:
					set_foraging(FORAGING.KILLING)
			else:
				set_foraging(FORAGING.EATING)
				
		FORAGING.EATING_DONE:
			
			if %Food.my_weight > foragers * 30:
				set_foraging(FORAGING.TOO_HEAVY_TO_CARRY)
			if %Food.my_weight <= 5:
				set_foraging(FORAGING.LEAVE)
			else:
			
				set_foraging(FORAGING.RETURN)
		
		FORAGING.TOO_HEAVY_TO_KILL:
			set_foraging(FORAGING.LEAVE)
		
		FORAGING.TOO_HEAVY_TO_CARRY:
			%Food.set_null()
			set_foraging(FORAGING.RETURN)
		
		FORAGING.RETURN_DONE:
			if !%Food.get_null():
				stored_food += %Food.my_weight
				%Food.set_null()
			stored_food += get_foragers().size() * 4
			set_foraging(FORAGING.IDLE)
			for i in get_foragers():
				i.set_state(i.STATE_IDLE)
				i.remove_from_group("Foragers")
		
		FORAGING.DEAD:
			set_foraging(FORAGING.IDLE)
			
		FORAGING.GAMEOVER:
			_on_queen_die()


func send_foragers():
	var idles = get_idle_ants()
	for i in foragers:
		idles[i].set_state(idles[i].STATE_LEAVE)
		idles[i].add_to_group("Foragers")
		set_foraging(FORAGING.LEAVE)
		%SendDialog.hide()
		%ForageLabel.show()
	%AntFollow.create_ants(true, foragers)
	calculate_time_to_change()


func calculate_time_to_change():
	time_to_change = 10


func forage_for_food():
	if time_to_change <= 0:
		set_foraging(FORAGING.FOUND)


func set_foraging(f: int):
	foraging = f
	%ForageLabel.state = f
	
	match f:
		FORAGING.IDLE:
			%ForageLabel.hide()
			%ButtonOK.show()
			%SendDialog.show()
		FORAGING.LEAVE:
			NewsHandler.broadcast("Brave foragers leave...")
			%ButtonOK.hide()
			time_to_change = 10
		FORAGING.FOUND:
			%ButtonOK.show()
		FORAGING.INVEST:
			NewsHandler.broadcast("Our girls found something!")
			%ButtonOK.hide()
			time_to_change = 5
		FORAGING.INVEST_DONE:
			%Food.initialize()
			%ButtonOK.show()
		FORAGING.EATING:
			%ButtonOK.hide()
			time_to_change = 5
		FORAGING.EATING_DONE:
			%ButtonOK.show()
		FORAGING.RETURN:
			NewsHandler.broadcast("The perilous %scm voyage..." % distance_from_nest)
			%ButtonOK.hide()
			time_to_change = distance_from_nest/4
		FORAGING.RETURN_DONE:
			%ButtonOK.show()
			%AntFollow.create_ants(false, foragers)
		FORAGING.DEAD:
			%ButtonOK.show()
		FORAGING.GAMEOVER:
			%ButtonOK.show()
			%SendDialog.hide()


func _on_weather_timer_timeout():
	var new = randi_range(0, 5)
	if new > 2:
		new = WEATHER.CLEAR
	if new != weather:
		%WeatherLabel.text = "Weather: %s" % WEATHER.keys()[new]
		weather = new
		for i in [%Rain, %Wind, %Leaves]: i.emitting=false
		if weather == WEATHER.RAIN:
			%Rain.emitting = true
		if weather == WEATHER.WIND:
			%Wind.emitting = true
			%Leaves.emitting = true


func _on_baby_timer_timeout():
	for i in randi_range(2,4):
		%Ants.add_child(Ant.new())
	NewsHandler.broadcast("Our queen had babies!")


func _on_queen_die():
	Score.score = 0
	get_tree().change_scene_to_file("res://main.tscn")


func _on_ant_queen_gameover(i):
	set_foraging(FORAGING.GAMEOVER)
