extends PanelContainer

@onready var key_container = $MarginContainer/PropertyContainer/KeyContainer
@onready var value_container = $MarginContainer/PropertyContainer/ValueContainer

var fps

func _ready():
	visible = false
	add_property("fps", fps)

func _process(delta):
	fps = int("%.2f" % (1.0 / delta)) # Works better than: Engine.get_frames_per_second()
	update_property("fps", fps)

func _input(event):
	if event.is_action_released("debug"):
		visible = !visible

func add_property(title: String, value):
	var key_label = Label.new()
	key_label.name = title
	key_label.text = title
	key_label.uppercase = true
	key_label.add_theme_color_override("font_color", Color("#42f5ce"))
	key_container.add_child(key_label)

	var value_label = Label.new()
	value_label.name = title + "_value"
	value_container.add_child(value_label)
	value_label.text = str(value)

func update_property(title: String, value):
	var value_label = find_label_by_name(value_container, title + "_value")
	if value_label:
		value_label.text = str(value)

func find_label_by_name(container: Control, label_name: String) -> Label:
	for child in container.get_children():
		if child is Label and child.name == label_name:
			return child
	return null
	
