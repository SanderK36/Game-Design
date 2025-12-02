extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var message_label: Label = $MessageLabel
@onready var restart_button: Button = $RestartButton

var score: int = 0

func _ready() -> void:
	restart_button.pressed.connect(_on_restart_button_pressed)
	update_score(0)

func update_score(new_score: int) -> void:
	score = new_score
	score_label.text = "Score: %s" % score

func show_game_over() -> void:
	message_label.show()
	restart_button.show()
	get_tree().paused = true  # Pauser alt (mobs stopper!)

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()  # Restart hele spillet!
