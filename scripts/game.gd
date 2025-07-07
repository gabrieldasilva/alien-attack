extends Node2D

var lives = 3
var score = 0

var game_over_scene = preload("res://scenes/game_over_screen.tscn")

@onready var player = $Player
@onready var ui = $UI
@onready var hud = $UI/HUD

@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_damage_sound = $PlayerDamageSound

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_deathzone_area_entered(enemy: Area2D) -> void:
	enemy.queue_free()

func _on_player_took_damage() -> void:
	lives -= 1
	hud.set_lives(lives)
	
	# When player gets damage, play th explode sound
	player_damage_sound.play()
	
	if (lives == 0):
		print("game over")
		player.die()
		
		await get_tree().create_timer(1).timeout
		
		var gos = game_over_scene.instantiate()
		gos.set_score(score)
		ui.add_child(gos)

func _on_enemy_spawner_enemy_spawned(enemy_instance: Variant) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died() -> void:
	score += 100
	hud.set_score_label(score)
	
	# Play enemy hit sound
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance: Variant) -> void:
	# TODO: I think this can be done on the enemy_spawner scene.
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
