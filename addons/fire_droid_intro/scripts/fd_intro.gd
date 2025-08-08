@tool
extends Node
class_name FDIntro


@export_tool_button("Generate Intro", "AnimationMixer")
var _generate_intro_button: Callable = _generate_intro

@onready var _animation_player: AnimationPlayer = get_node_or_null("AnimationPlayer")
@onready var _texture_rect: TextureRect = get_node_or_null("TextureRect")


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func generate_intro() -> void:
	_generate_intro()


func _generate_intro() -> void:
	if _animation_player == null:
		_animation_player = AnimationPlayer.new()
		add_child(_animation_player, true)
		_animation_player.set_owner(self)
	if _texture_rect == null:
		_texture_rect = TextureRect.new()
		add_child(_texture_rect, true)
		_texture_rect.set_owner(self)
		_texture_rect.call_deferred(&"set_anchors_preset", Control.PRESET_FULL_RECT)
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
	var track_index: int = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, _texture_rect.name + ":texture")
