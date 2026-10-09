extends CheckBox

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Narration")
	toggled.connect(_on_value_changed)

	
func _on_value_changed(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_volume_linear(bus_index, 1)
	else:
		AudioServer.set_bus_volume_linear(bus_index, 0)
	
		
