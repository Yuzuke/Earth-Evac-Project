extends Control

var playBtn
var quitBtn
var pauseMenu : VBoxContainer
var isGameStart = false
func _ready():
	playBtn = get_child(0)
	quitBtn = get_child(1)
	pauseMenu = get_child(2)
	pauseMenu.hide()
	

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if pauseMenu.is_visible_in_tree():
				pauseMenu.hide()
				get_tree().paused = false
			elif !playBtn.is_visible_in_tree():
				pauseMenu.show()
				get_tree().paused = true
				

func _on_Play_pressed():
	yield(get_tree().create_timer(1),"timeout")
	playBtn.hide()
	quitBtn.hide()
	


func _on_Quit_pressed():
	get_tree().quit()


func _on_resume_pressed():
	pauseMenu.hide()
	get_tree().paused = false


func _on_quit_pressed():
	get_tree().quit()
