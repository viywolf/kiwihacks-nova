extends Node3D

@onready var camera = $CharacterBody3D

const earth_number: float = 36.845
const auckland_number: float = 40.9
const person_number: float = 45

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Narration.stop()
	$Narration.stream = load("res://assets/audio/Beforeword.mp3")
	$Narration.play()
	for i in range($NarrationAreas.get_child_count()):
		var current_area: Area3D = $NarrationAreas.get_child(i)
		current_area.body_entered.connect(zone_reached.bind(i))


func _physics_process(delta: float) -> void:
	if $CharacterBody3D.position.z > 49:
		$CanvasLayer/urplcinspace.show()
	else:
		$CanvasLayer/urplcinspace.hide()
	if $CharacterBody3D.position.z > person_number:
		$CanvasLayer/people.show()
		$CanvasLayer/NZ_map.show()
		$CanvasLayer/Earth_texture.hide()
		$CanvasLayer/people.scale = Vector2(0.2 + (($CharacterBody3D.position.z - person_number) * 10 * delta), 0.2 + (($CharacterBody3D.position.z - person_number) * 10 * delta))
		$CanvasLayer/people.scale.x = min($CanvasLayer/people.scale.x, 0.3)
		$CanvasLayer/people.scale.y = $CanvasLayer/people.scale.x
		$CanvasLayer/people.rotation_degrees = ($CharacterBody3D.position.z - person_number) * 20
	elif $CharacterBody3D.position.z > auckland_number:
		$CanvasLayer/NZ_map.show()
		$CanvasLayer/Earth_texture.hide()
		$CanvasLayer/people.hide()
		$CanvasLayer/NZ_map.scale = Vector2(0.7 + (($CharacterBody3D.position.z - auckland_number) * 15 * delta), 0.7 + (($CharacterBody3D.position.z - auckland_number) * 15 * delta))
		$CanvasLayer/NZ_map.position.x = ($CharacterBody3D.position.z - auckland_number) * -8000 * delta
	elif $CharacterBody3D.position.z > earth_number:
		$CanvasLayer/Earth_texture.show()
		$CanvasLayer/NZ_map.hide()
		$CanvasLayer/people.hide()
		$CanvasLayer/Earth_texture.scale = Vector2(1.5 + (($CharacterBody3D.position.z - earth_number) * 25 * delta), 1.5 + (($CharacterBody3D.position.z - earth_number) * 25 * delta))
		$CanvasLayer/Earth_texture.position.x = ($CharacterBody3D.position.z - earth_number) * 2000 * delta
	else:
		$CanvasLayer/Earth_texture.hide()
		$CanvasLayer/NZ_map.hide()


func zone_reached(body, index: int):
	print("reached zone " + str(index))
	$CanvasLayer/Label.show()
	$CanvasLayer/Label.text = Narration.narration_text[index]
	$CanvasLayer/Label.visible_characters = 0
	$Narration.stop()
	$Narration.stream = load(Narration.narration_audio[index])
	$Narration.play()
	while $CanvasLayer/Label.visible_characters < len($CanvasLayer/Label.text):
		$CanvasLayer/Label.visible_characters += 1
		await get_tree().create_timer(0.05).timeout
	
