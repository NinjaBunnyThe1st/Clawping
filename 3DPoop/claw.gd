extends XROrigin3D
@onready var player_body:Node3D = get_parent()
# The Mesh from the player hands
var obj:MeshInstance3D
var obj2:MeshInstance3D
# Hands
@onready var left:Area3D = $Left/h
@onready var right:Area3D = $Right/h
# Original Hand Mesh Position
var op:Vector3
var op2:Vector3
# is_climbing from triggers
var is_climbing = false
# is falling (should be after ClawPing.player.climbing and is_climbing be false)
var fall = false
# If hands are active (ra = right hand)
var ra:bool = false
var la:bool = false
# "Do Both" SHould be if ra and la is active
var db:bool = false
# Original Hand Position
var ihp: Vector3
var ihp2: Vector3
# Original Player Position
var ipp: Vector3
func _ready():
	ProjectSettings.set_setting("physics_engine/3d/jolt/collisions/areas_detect_static_bodies", true)
	left.monitoring = true
	left.collision_layer = 1
	left.collision_mask = 2
	right.monitoring = true
	right.collision_layer = 1
	right.collision_mask = 2
	left.get_parent().connect("button_pressed",_lp)
	left.get_parent().connect("button_released",_lr)
	right.get_parent().connect("button_pressed",_rp)
	right.get_parent().connect("button_released",_rr)
func _lp(t):
	_otp(t,"Left")
func _lr(t):
	if la:
		_otr(t,"Left")
func _rp(t):
	_otp(t,"Right")
func _rr(t):
	if ra:
		_otr(t,"Right")
	
var smooth_speed = 20.0  

func _physics_process(delta):
	if Clawping.player.climbing and is_climbing:
		var target_pos = Vector3()
	
		if !db:
			var hd = obj.get_parent().global_transform.origin - ihp
			target_pos = Vector3(ipp.x-hd.x,ipp.y-hd.y,ipp.z-hd.z)
		else:
			var hd = obj.get_parent().global_transform.origin - ihp
			var hd2 = obj.get_parent().global_transform.origin - ihp2
			var ht = (hd+hd2)/2
			target_pos = Vector3(ipp.x-ht.x,ipp.y-ht.y,ipp.z-ht.z)
		player_body.global_position = player_body.global_position.lerp(target_pos, delta * smooth_speed)
		obj.global_position = op
		if db:
			obj2.global_position = op2
	
func _otp(t,r):
	if Clawping.player.real:
		if t=="trigger_click":
			print("ok")
	# Clawping.player.climbing is according to the climbables not this script
			if Clawping.player.climbing:
				print("real")
				is_climbing = true
				if !ra or !la:
					if r=="Left":
						obj = get_child(2).get_child(0)
						la = true
						db = false
						print("what")
					else:
						obj = get_child(1).get_child(0)
						ra = true
						db = false
				if ra and la:
					db = true
					obj = get_child(2).get_child(0)
					obj2 = get_child(1).get_child(0)
				if !db:
					op = obj.global_position
					ihp = obj.global_transform.origin
				else:
					op = obj.global_position
					op2 = obj2.global_position
					ihp = obj.global_transform.origin
					ihp2 = obj2.global_transform.origin
				Clawping.player.playsfx("climb")
				
		Clawping.player.primary_ray.enabled = false
		ipp = player_body.global_transform.origin
func _otr(t,r):
	if t=="trigger_click":
		if r=="Left":
			la = false
		else:
			ra = false
		
		if !ra and !la:
			is_climbing = false
			if !Clawping.player.real:
				Clawping.player.climbing = false
			_rph()
			if !Clawping.player.climbing and !is_climbing:
				fall = true
			Clawping.player.primary_ray.enabled = true
		else:
			db = false
			_rph(r)
# Short for reset hand position
func _rph(r:String = ""):
	if r=="":
		get_child(2).get_child(0).position = Vector3(0,0,0)
		get_child(1).get_child(0).position = Vector3(0,0,0)
	elif r=="Left":
		get_child(2).get_child(0).position = Vector3(0,0,0)
	elif r=="Right":
		get_child(1).get_child(0).position = Vector3(0,0,0)
