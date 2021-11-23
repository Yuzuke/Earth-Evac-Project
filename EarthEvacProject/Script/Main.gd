extends Node2D
export var starPlaceDistance = 50

var starList : Array
var BGDirection : Vector2

func _ready():
	$earth.connect("forwardThrust",self,"offsetBG")


func _physics_process(delta):
	offsetBG_delta(delta)
	pass


func deleteStars():
	starList.remove(0)
	

#test
func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.scancode == KEY_R:
			
			place_stars()

func place_stars():
	var random = rand_range(-500,500)
	var starPos : Vector2 = $earth.position
	var earthRotationDegrees = $earth.rotation_degrees
#	print(earthRotationDegrees)
	if earthRotationDegrees > 315 or earthRotationDegrees < 45:
		starPos += Vector2(random,-starPlaceDistance)
	if earthRotationDegrees > 45 and earthRotationDegrees < 135:
		starPos += Vector2(starPlaceDistance,random)
	if earthRotationDegrees > 135 and earthRotationDegrees < 225:
		starPos += Vector2(random,starPlaceDistance)
	if earthRotationDegrees > 225 and earthRotationDegrees < 315:
		starPos += Vector2(-starPlaceDistance,random)
	var star = preload("res://Scenes/star-01.tscn").instance()
	star.position = starPos-$Control/ParallaxBackground.offset
	$Control/ParallaxBackground/StarLayer.add_child(star)
	starList.append(star)
	
	


func offsetBG():
	var currentDegree : float = $earth.rotation
	BGDirection = Vector2(-sin(currentDegree),cos(currentDegree))
#	print(BGDirection)

func offsetBG_delta(delta):
	$Control/ParallaxBackground.offset += BGDirection * delta
	print($Control/ParallaxBackground.offset)
