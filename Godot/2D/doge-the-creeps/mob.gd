extends RigidBody2D

func _ready() -> void:
	$AnimatedSprite2D.play("walk")
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
