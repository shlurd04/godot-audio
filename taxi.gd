extends Node3D

@export var speed : float = 10
@export var maxDistance : float = 50.0
var startPos : Vector3

func _ready() -> void:
	startPos = position
	

func _process(delta: float) -> void:
	translate(basis.z * speed * delta)
	
	if position.distance_to(startPos) > maxDistance:
		position = startPos
