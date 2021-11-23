extends KinematicBody2D

signal forwardThrust
signal rightThrust
signal leftThrust
var thrusters
export var rotateSpd : float = 1
export var thrustPower_rotation : float = 0.01


enum GameState{
	PAUSE,
	NORMAL,
	DEAD,
	FINISH
}
export var state = GameState.PAUSE


func _ready():
	connect("rightThrust",self,'rightThrustExcute')
	connect("leftThrust",self,"leftThrustExcute")
	thrusters = get_child(3)
	thrusters.hide()
	var allThrusters = thrusters.get_children()
	for thruster in allThrusters:
		thruster.emitting = false
	var s_width : float
	var s_height : float
	s_width = get_viewport_rect().size.x
	s_height = get_viewport_rect().size.y
	#initial pos
	position = Vector2(s_width/2,s_height*.6)


func _physics_process(delta):
	#confine 360
	if rotation_degrees > 360:
		rotation_degrees -= 360
	if rotation_degrees < 0:
		rotation_degrees += 360
	
	self.rotation += rotateSpd * delta
#	print(position)
	if $thrusters_1/forward_thrust.emitting == true:
		emit_signal("forwardThrust")
	if $thrusters_1/right_thrust.emitting == true:
		emit_signal("rightThrust")
	if $thrusters_1/left_thrust.emitting == true:
		emit_signal("leftThrust")

func _unhandled_input(event):
	#input
	if state == GameState.NORMAL:
		_inputUpdate(event)



func _inputUpdate(event):
		# UI input update
	if event is InputEventKey:
		if event.is_pressed() and event.scancode == KEY_E:
			if !thrusters.is_visible_in_tree():
				print('install thruster group 01')
				thrusters.show()
				
	if thrusters.is_visible_in_tree():
		_earthManeuverUpdate(event)


func _earthManeuverUpdate(event):
	if Input.is_action_pressed("thrust_rotation_l"):
		
		$thrusters_1/right_thrust.emitting = true
	if Input.is_action_just_released("thrust_rotation_l"):
		$thrusters_1/right_thrust.emitting = false
		
	if Input.is_action_pressed("thrust_rotation_r"):
		
		$thrusters_1/left_thrust.emitting = true
	if Input.is_action_just_released("thrust_rotation_r"):
		$thrusters_1/left_thrust.emitting = false
		
	if Input.is_action_pressed("thrust_forward"):
		
		$thrusters_1/forward_thrust.emitting = true
		
	if Input.is_action_just_released("thrust_forward"):
		$thrusters_1/forward_thrust.emitting = false
	
	
func rightThrustExcute():
	rotateSpd -= thrustPower_rotation

func leftThrustExcute():
	rotateSpd += thrustPower_rotation

func _on_Play_pressed():
	print('start')
	state = GameState.NORMAL
