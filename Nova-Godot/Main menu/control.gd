extends Control

func _ready():
	%Play.pressed.connect(play)

func play():
	get_tree().change_scene_to_file(
		'res://ZoomScene/zoom_scene_3d.tscn')
	


func _on_settings_pressed() -> void:
	$Settings.show()
