extends Node3D
class_name Pooper

@onready var origin:XROrigin3D
@onready var head:XRCamera3D 
@onready var left_hand:XRController3D 
@onready var left_ray:RayCast3D 
@onready var right_hand:XRController3D 
@onready var right_ray:RayCast3D

var primary_ray:RayCast3D

func update_primary_ray():
	if Clawping.lefth:
		primary_ray = left_ray
		left_ray.enabled = true
		right_ray.enabled = false
	else:
		primary_ray = right_ray
		left_ray.enabled = false
		right_ray.enabled = true

func _ready():
	origin = $XROrigin3D
	head = $XROrigin3D/Head
	left_hand = $XROrigin3D/Left
	left_ray= $XROrigin3D/Left/RayCast3D
	right_hand = $XROrigin3D/Right
	right_ray = $XROrigin3D/Right/RayCast3D
	update_primary_ray()
	set_process(true)
func setR(r):
	var radians = deg_to_rad(r)
	var ror = $Origin/RightHand.rotation
	var rol = $Origin/LeftHand.rotation 
	var rotatio = Vector3( 1*radians+ror.x,ror.y, ror.z)
	$Origin/RightHand.rotation = rotation
	rotatio = Vector3( 1*radians+rol.x,rol.y, rol.z)
	$Origin/LeftHand.rotation = rotation
func _process(_delta):
	if Input.is_action_just_pressed("sh"):
		Clawping.lefth = !Clawping.lefth
		update_primary_ray()
	primary_ray.force_raycast_update()
	primary_ray.update_beam()
