extends Node3D
class_name Pooper

@onready var origin:XROrigin3D
@onready var head:XRCamera3D 
@onready var left_hand:XRController3D 
@onready var left_ray:RayCast3D 
@onready var right_hand:XRController3D 
@onready var right_ray:RayCast3D
@onready var audio:AudioStreamPlayer
@onready var climbing:bool = false
@onready var real:bool = false
@onready var on_fl:bool = true
@onready var rhc:bool = false
@onready var lhc:bool = false

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
	audio = $audio
	update_primary_ray()
	set_process(true)
	left_hand.connect("button_pressed",shi)
	right_hand.connect("button_pressed",shi)
	climbing = false
	origin._rph()
func shi(e):
	if e=="ax_button":
		Clawping.lefth = !Clawping.lefth
		update_primary_ray()
	
func _process(_delta):
	primary_ray.force_raycast_update()
	primary_ray.update_beam()
func playsfx(s:String = "") -> void:
	match(s):
		"hit":
			audio.stream = AudioStreamMP3.load_from_file("res://Poop/sfx/csfx.mp3")
		"rel":
			audio.stream = AudioStreamMP3.load_from_file("res://Poop/sfx/release.mp3")
	audio.play()
	
