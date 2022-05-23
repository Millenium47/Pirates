class_name Cannon
extends Node2D

export (PackedScene) var Cannonball
export var fire_cooldown := 1.0

onready var _cannonball_spawn_position = $ProjectileSpawnPosition
onready var _cooldown_timer = $CooldownTimer
var enemies = []

func _physics_process(_delta: float) -> void:
	if not _cooldown_timer.is_stopped():
		return
	
	var enemy = target()
	
	if !enemy:
		return
	
	shoot_at(enemy.global_position)
	
func target():
	if enemies.empty():
		return 
	return enemies[0]
	
func shoot_at(target_position: Vector2) -> void:
	var cannonball = Cannonball.instance()
	add_child(cannonball)
	cannonball.global_position = _cannonball_spawn_position.global_position
	cannonball.fly_to(target_position)
	_cooldown_timer.start(fire_cooldown)
	
func _on_Range_area_entered(enemy: Area2D):
	enemies.append(enemy)

func _on_Range_area_exited(enemy: Area2D):
	enemies.erase(enemy)
