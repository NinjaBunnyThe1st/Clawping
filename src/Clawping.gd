extends Node
# root

signal farted
# if in vr
var vr:bool = false
var v
var player:Pooper
var target
# Do vr
var farter:bool=false
var fir_fart:bool=false
var fartface:XRInterface
var lefth:bool=false
var menuR:bool=false
# audios
var sound:AudioStream
# packed scences or nodes
var pooper:Node 
var rsods:PackedScene 
func fart_vr():
	fartface = v
	if fartface and fartface.is_initialized():
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		get_viewport().use_xr = true
	else: rsod("No fart")
	set_keys()
	
	var the=get_tree().root.add_child
	the.call_deferred(pooper)
	pooper.name = "Pooper"
	player = pooper
	

func set_keys():
	
	var ev = InputEventAction.new()
	ev.action = "Trigger click"
	InputMap.action_add_event("click", ev)
	
	ev = InputEventAction.new()
	ev.action = "menu-button"
	InputMap.action_add_event("pause", ev)
	
	ev = InputEventAction.new()
	ev.action = "by_button"
	InputMap.action_add_event("back", ev)
	
	ev = InputEventAction.new()
	ev.action = "primary_click"
	InputMap.action_add_event("sh", ev)
	
	#ev = InputEventAction.new()
	#ev.axis = "aim_pose"
	#InputMap.action_add_event("aim", ev)
	
#Main
func fart():
	emit_signal("farted","Loading Pooper!!!")	
	var interface = XRServer.find_interface("OpenXR")
	interface.initialize()
	v = interface
	pooper = load("res://3DPoop/pooper.tscn").instantiate()
	rsods = load("res://2DPoop/ui/rsod.tscn")
	Clawping.fart_vr()
	emit_signal("farted","Hello Pooper!!!11")
	emit_signal("farted","real",true)
# Red Screen of Death :wilted-flower: :knife:
func rsod(e:String):
	var lol:Node=rsods.instantiate()
	if get_node("/root/Pooper"):
		get_node("/root/Pooper").add_child.call_deferred(lol)
	lol.name = "RSOD"
	lol.get_child(0).get_child(0).get_child(2).text = e
# file data test
func make_poop(_data:Array):
	var _path=Golbs.p("")
# get audio stream
func get_stream(path: String, default: AudioStream) -> AudioStream:
	path = Golbs.p(path)
	var file = FileAccess.open(path + ".ogg", FileAccess.READ)
	if file == null:
		file = FileAccess.open(path + ".mp3", FileAccess.READ)
		if file == null:
			file = FileAccess.open(path + ".wav", FileAccess.READ)
			if file == null:
				return default
			path += ".wav"
		else:
			path += ".mp3"
	else:
		path += ".ogg"

	if !path.begins_with("res://"):
		var stream = Golbs.audioLoader.load_file(path)
		if stream is AudioStream:
			return stream
	else:
		var mf = load(path) as AudioStream
		if mf is AudioStream:
			return mf

	return default
# Sever create (testing multiplayer)
func mpcs():
	var eer = ENetMultiplayerPeer.new()
	eer.create_server(6969, 32)
	multiplayer.multiplayer_peer = eer
	
@rpc("any_peer", "call_local", "reliable")
func ie():
	var sender_id = multiplayer.get_remote_sender_id()
	print(sender_id)
