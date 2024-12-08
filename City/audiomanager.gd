extends Node

@onready var window : Panel = get_node("AudioWindow")
@onready var masterSlider : HSlider = get_node("AudioWindow/MasterSlider")
@onready var sfxSlider : HSlider = get_node("AudioWindow/SFX Slider")
@onready var musicSlider : HSlider = get_node("AudioWindow/Music Slider")

var masterIndex : int
var sfxIndex : int
var musicIndex : int

func _ready() -> void:
	masterIndex = AudioServer.get_bus_index("Master")
	sfxIndex = AudioServer.get_bus_index("SFX")
	musicIndex = AudioServer.get_bus_index("Music")
	
	masterSlider.value = _get_volume(masterIndex)
	sfxSlider.value = _get_volume(sfxIndex)
	musicSlider.value = _get_volume(musicIndex)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		window.visible = !window.visible
		
		if window.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _get_volume(bus_index : int) -> float:
	var dbVolume = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(dbVolume)

func _set_volume(bus_index : int, volume : float) -> void:
	var dbVolume = linear_to_db(volume)
	AudioServer.set_bus_volume_db(bus_index, dbVolume)


func _on_master_slider_value_changed(value: float) -> void:
	_set_volume(masterIndex, value)


func _on_music_slider_value_changed(value: float) -> void:
	_set_volume(musicIndex, value)


func _on_sfx_slider_value_changed(value: float) -> void:
	_set_volume(sfxIndex, value)
