extends PathFollow2D

var dir = false

func _ready():
	if not dir:
		progress_ratio = 0.99
	else: progress_ratio = 0.01

func _physics_process(delta):
	
	$ColorRect.position = Vector2(randf_range(-1,1),randf_range(-1,1))
	if dir:
		progress_ratio += 0.01
	else:
		progress_ratio -= 0.01
	if progress_ratio <= 0 or progress_ratio >= 1:
		queue_free()
