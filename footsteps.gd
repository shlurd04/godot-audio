extends AudioStreamPlayer3D

@export var footstepSounds : Array [AudioStream]
@export var playRate : float = 0.5
var lastPlayTime : float
@export var minVelocity : float = 0.5

@onready var Player : CharacterBody3D = get_parent()

func _process(delta: float) -> void:
	if not Player.is_on_floor():
		return
	
	if Player.velocity.length() < minVelocity:
		return
	
	if Time.get_unix_time_from_system() - lastPlayTime < playRate:
		return
	
	lastPlayTime = Time.get_unix_time_from_system()
	stream = footstepSounds[randi() % len(footstepSounds)]
	play()
	
