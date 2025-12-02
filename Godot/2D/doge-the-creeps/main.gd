extends Node2D

@export var mob_scene: PackedScene

@onready var player = $Player
@onready var mob_timer = $MobTimer
@onready var score_timer = $ScoreTimer
@onready var ui = $UI

var score: int = 0

func _ready() -> void:
	player.start($StartPosition.position)
	mob_timer.timeout.connect(_on_mob_timer_timeout)
	score_timer.timeout.connect(_on_score_timer_timeout)
	player.hit.connect(_on_player_hit)
	mob_timer.start()
	score_timer.start()

func _on_mob_timer_timeout() -> void:
	# Spawn-kode som før (kopier fra tidligere)
	var mob_instance = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob_instance.position = mob_spawn_location.position
	
	var direction_angle = mob_spawn_location.rotation + PI / 2
	direction_angle += randf_range(-PI / 4, PI / 4)
	mob_instance.rotation = direction_angle
	
	var speed = randf_range(150, 250)
	var velocity = Vector2(speed, 0)
	mob_instance.linear_velocity = velocity.rotated(direction_angle)
	
	add_child(mob_instance)

func _on_score_timer_timeout() -> void:
	score += 1
	ui.update_score(score)

func _on_player_hit() -> void:
	mob_timer.stop()
	score_timer.stop()
	ui.show_game_over()
