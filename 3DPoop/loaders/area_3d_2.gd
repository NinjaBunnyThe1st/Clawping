extends Area3D

func _ready() -> void:
	monitoring = true  # Enable area monitoring
	

func _physics_process(_delta: float):
	# Get all overlapping areas
	var overlapping_areas = get_overlapping_areas()
	
	# Reset states
	Clawping.player.lhc = false
	Clawping.player.rhc = false
	
	# Check each overlapping area
	for area in overlapping_areas:
		print(area.get_parent().name)
		if area.get_parent().name == "Left":
			print("lol")
			Clawping.player.lhc = true
		elif area.get_parent().name == "Right":
			Clawping.player.rhc = true
	
	# Update real state
	Clawping.player.real = Clawping.player.lhc or Clawping.player.rhc
