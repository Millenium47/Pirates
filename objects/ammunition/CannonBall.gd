class_name Cannonball
extends Node2D

export var speed := 500.0

onready var _anim_player := $AnimationPlayer
onready var _tween := $Tween

func _init() -> void:
	set_as_toplevel(true)

func fly_to(target_global_position: Vector2) -> void:
	var distance := global_position.distance_to(target_global_position)
	var duration := distance / speed
	look_at(target_global_position)

	_tween.interpolate_property(
		self, "global_position", global_position, target_global_position, duration
	)
	_tween.start()
	look_at(target_global_position)
	yield(_tween, "tween_all_completed")

