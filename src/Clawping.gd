extends Node
# root
var rot = get_tree().root
# if in vr
var vr:bool = false
var v
var player:Pooper
var target
# Do vr
func fart_vr():
	var viewport = get_viewport()
	viewport.hdr = false
	Engine.max_fps = 120
	

	if v.initialize():
		print("Failed to initialize VR!")
		return	
	viewport.arvr = true
	set_keys()
	var vr_av = load("res://3DPoop/pooper.tscn").instance()
	rot.add_child(vr_av)
	vr_av.name = "Pooper"
	player = vr_av
	target = "res://vr/sel.tscn"
	get_tree().change_scene("res://3DPoop/load.tscn")

func set_keys():
	
	var ev = InputEventJoypadButton.new()
	ev.button_index = 7
	InputMap.action_add_event("vr_switch_hands", ev)
	
	
#Main
func fart():
	var interface = XRServer.find_interface("OpenVR")
	if interface:
		v = interface
		Clawping.fart_vr()
