# I might go sigmasaning :D
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
# "Do Both" Should be if ra and la is active
var db:bool = false
# Original Hand Position
var ihp: Vector3
var ihp2: Vector3
# Original Player Position
var ipp: Vector3
# jump data
const MAX_POSITIONS = 10
var left_hand_positions = []
var right_hand_positions = []
# gavity
var garn:float = 0.0000001
var garnspeed:float = 0.00005

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
	if la:_otr(t,"Left")
func _rp(t):
	_otp(t,"Right")
func _rr(t):
	if ra:_otr(t,"Right")
	
var smooth_speed = 20.0  
var left_hand_velocity = Vector3()
var right_hand_velocity = Vector3()
var last_left_hand_pos = Vector3()
var last_right_hand_pos = Vector3()
var jump:Vector3
var ogjump:Vector3
var jump_time 
var is_jumping = false
var jump_progress = 0
var slow:float = 1.0
var off:Vector3
func _physics_process(delta):
	if la:
		left_hand_positions.push_back(obj.get_parent().global_position)
		if left_hand_positions.size() > MAX_POSITIONS:
			left_hand_positions.pop_front()

	if ra:
		right_hand_positions.push_back(obj.get_parent().global_position)
		if right_hand_positions.size() > MAX_POSITIONS:
			right_hand_positions.pop_front()
			
	if is_jumping:
		jump_progress += delta/jump_time
		off = Huzz.mv(player_body.global_position,jump)
		jump.y=jump.y*slow
		player_body.global_position = off
		if jump_progress >= 0.3:
			slow = slow*0.99
		if jump_progress >= 1.0:
			is_jumping = false
			fall = true
		
	if Clawping.player.climbing and is_climbing:
		var target_pos = Vector3()
		if la:
			left_hand_velocity = (obj.get_parent().global_position - last_left_hand_pos) / delta
			last_left_hand_pos = obj.get_parent().global_position
		if ra:
			right_hand_velocity = (obj.get_parent().global_position - last_right_hand_pos) / delta
			last_right_hand_pos = obj.get_parent().global_position
		if !db:
			var hd = obj.get_parent().global_position - ihp
			target_pos = Huzz.mv(ipp,hd)
		else:
			var hd = obj.get_parent().global_position - ihp
			var hd2 = obj2.get_parent().global_position - ihp2
			var ht = (hd+hd2)/2
			target_pos = Huzz.mv(ipp,ht)
		player_body.global_position = player_body.global_position.lerp(target_pos, delta * smooth_speed)
		
		obj.global_position = op
	
		if db:
			obj2.global_position = op2
	if fall:
		# Need to add hints of the jump from x and z
		# Bruh physic lowkey broken :skull:
		jump_progress = clamp(jump_progress - (delta / (jump_time*5)),0,1)
		print(jump_progress)
		off = Huzz.tj(ogjump,jump_progress)
		player_body.global_position.y -= clamp(garn,0,0.025)
		player_body.global_position.x = player_body.global_position.x+off.x
		player_body.global_position.z = player_body.global_position.z+off.z
		garn += garnspeed 
	
# On Trigger Press 	

func _otp(t:String,r:String):
	if Clawping.player.real:
		if t=="trigger_click":
			print("ok")
			Clawping.player.climbing = true
	# Clawping.player.climbing is according to the climbables not this script
			if Clawping.player.climbing and (get_parent().rhc or get_parent().lhc):
				print("real")
				is_climbing = true
				is_jumping = false
				fall = false
				off = Vector3.ZERO
				garn = 0.0
				if !ra or !la:
					if r=="Left" and get_parent().lhc:
						obj = get_child(2).get_child(0)
						la = true
						db = false
						print("what")
					elif r=="Right" and get_parent().rhc:
						obj = get_child(1).get_child(0)
						ra = true
						db = false
					else:
						Clawping.rsod("Hand doesn't exist?")
				if ra and la:
					db = true
					obj = get_child(2).get_child(0)
					obj2 = get_child(1).get_child(0)
				if !db:
					op = obj.global_position
					ihp = obj.global_position
				else:
					op = obj.global_position
					op2 = obj2.global_position
					ihp = obj.global_position
					ihp2 = obj2.global_position
				Clawping.player.playsfx("hit")
				
		Clawping.player.primary_ray.enabled = false
		ipp = player_body.global_position
		
# On Trigger Release

func _otr(t,r):
	if t=="trigger_click":
		Clawping.player.playsfx("rel")
		if r=="Left":
			la = false
			_perform_jump( _calculate_hand_velocity(left_hand_positions))
		else:
			ra = false
			_perform_jump(_calculate_hand_velocity(right_hand_positions))
		if !ra and !la:
			is_climbing = false
			if !Clawping.player.real:
				Clawping.player.climbing = false
			_rph()
			if !is_climbing:
				garn = 0.005
			Clawping.player.primary_ray.enabled = true
		else:
			db = false
			_rph(r)
			if r=="Left":
				obj = get_child(1).get_child(0)
				op = obj.global_position
				
# Short for reset hand position

func _rph(r:String = ""):
	if r=="":
		get_child(2).get_child(0).position = Vector3.ZERO
		get_child(1).get_child(0).position = Vector3.ZERO
	elif r=="Left":
		get_child(2).get_child(0).position = Vector3.ZERO
	elif r=="Right":
		get_child(1).get_child(0).position = Vector3.ZERO
		
func _perform_jump(l):
	is_jumping = true
	fall = false
	jump_progress = 0
	jump = l
	ogjump = l
	print(l.length())
	jump_time =l.length()*12
	slow = 1.0
	
func _calculate_hand_velocity(pos:Array) -> Vector3:
	if pos.size() < 2:
		return Vector3.ZERO
	var vel = Vector3()
	for i in range(1, pos.size()):
		
		vel = Huzz.av(vel,Huzz.mv(pos[i],pos[i-1]))
	return Huzz.dvf(vel,pos.size())
