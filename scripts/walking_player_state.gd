class_name WalkingPlayerState
extends State

func update(delta):
	if GameManager.player.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")
