extends Control


func _ready():
	%Play.pressed.connect(play)
	%Exit.pressed.connect(quit_game)
	
func play():
	get_tree().change_scene_to_file(
		'res://ZoomScene/zoom_scene_3d.tscn'
		
	)
	
	
func quit_game():
	get_tree().quit()
	


func _on_settings_pressed() -> void:
	$Settings.show()

func _on_button_pressed() -> void:
		$Settings.hide()


	
	
