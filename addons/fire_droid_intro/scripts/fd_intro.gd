@tool
extends Node
class_name FDIntro


@export_tool_button("Generate Animation", "AnimationMixer")
var _generate_intro_button: Callable = _generate_intro

@onready var _animation_player: AnimationPlayer = get_node_or_null("AnimationPlayer")


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func _generate_intro() -> void:
	if _animation_player == null:
		_animation_player = AnimationPlayer.new()
		add_child(_animation_player)
		_animation_player.set_owner(self)
	var animation_library: AnimationLibrary = (
		_animation_player.get_animation_library(&"FDIntro")
	)
	if animation_library == null:
		animation_library = AnimationLibrary.new()
		_animation_player.add_animation_library(&"FDIntro", animation_library)
	var animation: Animation = animation_library.get_animation(&"default")
	if animation == null:
		animation = Animation.new()
		animation_library.add_animation(&"default", animation)
	_update_default_animation(animation)


func _update_default_animation(animation: Animation) -> void:
	animation.clear()
	animation
