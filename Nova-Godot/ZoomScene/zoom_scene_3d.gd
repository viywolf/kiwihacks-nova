extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range($NarrationAreas.get_child_count()):
		var current_area: Area3D = $NarrationAreas.get_child(i)
		current_area.body_entered.connect(zone_reached.bind(i))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func zone_reached(body, index: int):
	print("reached zone " + str(index))
	$CanvasLayer/Label.show()
	$CanvasLayer/Label.text = Narration.narration_text[index]
	$CanvasLayer/Label.visible_characters = 0
	$Narration.play()
	while $CanvasLayer/Label.visible_characters < len($CanvasLayer/Label.text):
		$CanvasLayer/Label.visible_characters += 1
		await get_tree().create_timer(0.05).timeout
	await $Narration.finished
	$CanvasLayer/Label.hide()
	
