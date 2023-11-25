extends Node

var active := false

enum {weight, alive}

var type = ""
var my_weight = 0
var my_alive = false

var food_types = {
	"Caterpillar": {
		weight: 300,
		alive: true,},
	"Slug": {
		weight: 1000,
		alive: true,},
	"Leaf": {
		weight: 100,
		alive: false,},
	}


func initialize():
	
	var variability = 0.4
	
	var mytype = randi_range(0,6)
	mytype = min(mytype,food_types.size()-1)
	
	type = food_types.keys()[mytype]
	my_weight = food_types[type][weight]
	my_weight *= randf_range(1-variability,1+variability)
	
	my_alive = food_types[type][alive]
	if randi_range(1,5) == 2:
		my_alive = false


func set_null(): type = ""

func get_null(): return type == ""
