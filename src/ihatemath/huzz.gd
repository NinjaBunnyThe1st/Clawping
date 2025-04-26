# Math functions to impress the huzz fr
# I'm 6 foot btw
extends Node
# Sigma Vector Math
func mv(a:Vector3,b:Vector3) -> Vector3:
	return Vector3(a.x-b.x,a.y-b.y,a.z-b.z)
func mvf(a:Vector3,b:float) -> Vector3:
	return Vector3(a.x-b,a.y-b,a.z-b)
func av(a:Vector3,b:Vector3) -> Vector3:
	return Vector3(a.x+b.x,a.y+b.y,a.z+b.z)
func avf(a:Vector3,b:float) -> Vector3:
	return Vector3(a.x+b,a.y+b,a.z+b)
func muv(a:Vector3,b:Vector3) -> Vector3:
	return Vector3(a.x*b.x,a.y*b.y,a.z*b.z)
func muvf(a:Vector3,b:float) -> Vector3:
	return Vector3(a.x*b,a.y*b,a.z*b)
func dv(a:Vector3,b:Vector3) -> Vector3:
	return Vector3(a.x/b.x,a.y/b.y,a.z/b.z)
func dvf(a:Vector3,b:float) -> Vector3:
	return Vector3(a.x/b,a.y/b,a.z/b)
	
# Sigma Physics Math
func cj(a:float,b:float) -> float:
	return a * (1.0+pow(b, 3.0))
func tj(a:Vector3,b:float) -> Vector3:
	var x:float = cj(a.x,b)
	var y:float = cj(a.y,b)
	var z:float = cj(a.z,b)
	return mv(a,Vector3(x,y,z))
