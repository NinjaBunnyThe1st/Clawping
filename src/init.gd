extends Node
var target
func stage(text:String,done:bool=false):
	$SubViewport/Label3D.text = text
	if done:
#		black_fade_target = true
		$SubViewport/Label3D.text = "Loading menu"
		get_tree().change_scene("res://3DPoop/loaders/loadm")
func _ready():
	get_tree().paused = false
	Clawping.connect("farted",Callable.create(self,"stage"),2)
	Clawping.fart()
	
