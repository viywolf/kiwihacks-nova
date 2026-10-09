extends Node3D

@onready var camera = $CharacterBody3D

const earth_number: float = 36.845
const auckland_number: float = 40.9

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range($NarrationAreas.get_child_count()):
		var current_area: Area3D = $NarrationAreas.get_child(i)
		current_area.body_entered.connect(zone_reached.bind(i))


func _physics_process(delta: float) -> void:
	if $CharacterBody3D.position.z > auckland_number:
		$CanvasLayer/NZ_map.show()
		$CanvasLayer/Earth_texture.hide()
		$CanvasLayer/NZ_map.scale = Vector2(0.7 + (($CharacterBody3D.position.z - auckland_number) * 15 * delta), 0.7 + (($CharacterBody3D.position.z - auckland_number) * 15 * delta))
		$CanvasLayer/NZ_map.position.x = ($CharacterBody3D.position.z - auckland_number) * -8000 * delta
	elif $CharacterBody3D.position.z > earth_number:
		$CanvasLayer/Earth_texture.show()
		$CanvasLayer/NZ_map.hide()
		$CanvasLayer/Earth_texture.scale = Vector2(0.8 + (($CharacterBody3D.position.z - earth_number) * 25 * delta), 0.8 + (($CharacterBody3D.position.z - earth_number) * 25 * delta))
	else:
		$CanvasLayer/Earth_texture.hide()
		$CanvasLayer/NZ_map.hide()


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
	
