class_name DeadState
extends PlayerState

func enter() -> void:
	player.isDead = true
	player.velocity = Vector2.ZERO
	player.hurtbox.set_deferred("monitoring", false)
	player.hurtbox.set_deferred("monitorable", false)
	player.hurtbox.set_deferred("disabled", true)
	player.hitbox.set_active(false) 
	player.get_node("CollisionShape2D").set_deferred("disabled", true)
	player.sprite.play("Dead")
	player.sprite.animation_finished.connect(_on_dead_finished, CONNECT_ONE_SHOT)
	
func _on_dead_finished() -> void:
	player.sprite.pause()
	player.died.emit()
