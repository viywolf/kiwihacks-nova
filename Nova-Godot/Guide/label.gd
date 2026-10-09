extends Label

func _ready() -> void:
	visible_characters=0

func _process(delta: float) -> void:
	if visible:
		while visible_characters < len(text):
			visible_characters+=1
			await get_tree().create_timer(0.05).timeout	
