tool
extends EditorPlugin

const my_script_templates_path = "res://addons/AFSM/script_templates"

func _enter_tree() -> void:
	# Move script templates to the editor's script templates folder.
	var script_templates_dir = ProjectSettings.get_setting("editor/script_templates_search_path")
	if not Directory.new().dir_exists(script_templates_dir):
		var script_templates = Directory.new()
		script_templates.make_dir(script_templates_dir)

	copy_dir_to(my_script_templates_path, script_templates_dir)

func _exit_tree() -> void:
	# Remove custom types
	var files_to_remove = []
	var script_templates_dir = ProjectSettings.get_setting("editor/script_templates_search_path")
	files_to_remove=list_files(my_script_templates_path)
	remove_files(files_to_remove, script_templates_dir)

func list_files(path: String) -> Array:
	var dir = Directory.new()
	dir.open(path)
	var files = []
	dir.list_dir_begin(true, true)
	var file = dir.get_next()
	while file != "":
		if file != ".gdignore":
			files.append(file)
		file = dir.get_next()
	dir.list_dir_end()
	return files

# Copy all files from source to destination
func copy_dir_to(src: String, dst: String) -> void:
	var files = list_files(src)
	for file in files:
		var src_file = src.plus_file(file)
		var dst_file = dst.plus_file(file)
		Directory.new().copy(src_file, dst_file)

func remove_files(files_to_remove: Array, src: String) -> void:
	for file in files_to_remove:
		var src_file = src.plus_file(file)
		Directory.new().remove(src_file)