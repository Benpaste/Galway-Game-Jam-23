extends Node2D

const STARTING_ANTS = 6

var foragers = 0
var time_to_change = 0
enum FORAGING {IDLE, LEAVE, RETURN, FOUND,
EATING, EATING_DONE,
INVEST, INVEST_DONE}
var foraging = FORAGING.IDLE

func _ready():
	for i in STARTING_ANTS:
		var new_ant = Ant.new()
		%Ants.add_child(new_ant)


func _physics_process(delta):
	
	var pop_health = get_pop_health()
	%HealthbarPop.set_stats(pop_health[0],pop_health[1])
	%HealthbarQueen.set_stats(%AntQueen.health, %AntQueen.MAX_HEALTH)
	%PopLabel.value = get_pop_size()
	%PopLabel.foragers = foragers
	%DialogLabel.text = "Send %s to forage?" % foragers
	if foraging == FORAGING.IDLE:
		set_foragers(foragers)


func get_pop_size():
	return %Ants.get_child_count() - 1


func get_pop_health():
	
	var MAX_HEALTH = 0
	var health = 0
	
	for i in %Ants.get_children():
		if i != %AntQueen:
			MAX_HEALTH += i.MAX_HEALTH
			health += i.health
	
	return [health, MAX_HEALTH]


func do_tick():
	for i in %Ants.get_children():
		i.do_frame()
	
	time_to_change -= 1
	match foraging:
		FORAGING.LEAVE:
			forage_for_food()
		FORAGING.INVEST:
			if time_to_change <= 0:
				set_foraging(FORAGING.INVEST_DONE)
		FORAGING.EATING:
			if time_to_change <= 0:
				set_foraging(FORAGING.EATING_DONE)
			#check if foragers are done munching
			pass


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
			send_foragers()
		FORAGING.FOUND:
			set_foraging(FORAGING.INVEST)
		FORAGING.INVEST_DONE:
			
			#if food alive:
				#if too big to kill, forage again
				#else start killing
			#else:
				#foragers eat
				#if not too big to carry, carry it
				#foragers return
			
			set_foraging(FORAGING.EATING)
		FORAGING.EATING_DONE:
			set_foraging(FORAGING.RETURN)


func send_foragers():
	var idles = get_idle_ants()
	for i in foragers:
		idles[i].set_state(idles[i].STATE_LEAVE)
		set_foraging(FORAGING.LEAVE)
		%SendDialog.hide()
		%ForageLabel.show()
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
		FORAGING.LEAVE:
			%ButtonOK.hide()
		FORAGING.FOUND:
			%ButtonOK.show()
			#set random food source
		FORAGING.INVEST:
			%ButtonOK.hide()
			time_to_change = 5
		FORAGING.INVEST_DONE:
			%Food.initialize()
			%ButtonOK.show()
		FORAGING.EATING:
			pass
