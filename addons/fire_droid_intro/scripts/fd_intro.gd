@tool
extends Node
class_name FDIntro


@export var frames: SpriteFrames = null
@export_range(0.01, 60.0, 0.01, "or_greater") var fps: float = 30.0
@export_tool_button("Generate Intro", "AnimationMixer")
var _generate_intro_button: Callable = _generate_intro

var _animation_player_node_name: String = "AnimationPlayer"
var _texture_rect_node_name: String = "TextureRect"

@onready var _animation_player: AnimationPlayer = (
	get_node_or_null(_animation_player_node_name)
)
@onready var _texture_rect: TextureRect = (
	get_node_or_null(_texture_rect_node_name)
)


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
		add_child(_animation_player, true)#, Node.INTERNAL_MODE_FRONT)
		_animation_player_node_name = _animation_player.name
		_animation_player.set_owner(self)
	if _texture_rect == null:
		_texture_rect = TextureRect.new()
		add_child(_texture_rect, true)#, Node.INTERNAL_MODE_BACK)
		_texture_rect_node_name = _texture_rect.name
		_texture_rect.call_deferred(&"set_anchors_preset", Control.PRESET_FULL_RECT)
		_texture_rect.set_owner(self)
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
	var frame_count: int = frames.get_frame_count(&"default")
	var total_duration: float = 0.0
	var frame_duration: float = 0.0
	if frame_count > 0:
		total_duration = float(frame_count) / fps
		frame_duration = total_duration / float(frame_count)
	var track_index: int = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, _texture_rect.name + ":texture")
	animation.length = total_duration
	for i: int in frame_count:
		var frame: Texture2D = frames.get_frame_texture(&"default", i)
		animation.track_insert_key(track_index, i * frame_duration, frame)
