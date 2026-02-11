class_name CustomLogger extends Logger

var file: FileAccess
var name: String
const LOGGER_PATH: String = "user://logs/latest.log"
# var DATE_TIME_FORMAT: Dictionary = Time.get_datetime_dict_from_system()
# var TIME_FORMAT: String 

func _init(name: String) -> void:
	self.name = name
	DirAccess.make_dir_absolute("user://logs/")
	if (FileAccess.file_exists(LOGGER_PATH)):
		# if latest log already exists, retrieve it and rename it
		var existing = FileAccess.get_file_as_bytes(LOGGER_PATH)
		var new_file = FileAccess.open("user://logs/" + get_date_time_string() + ".log", FileAccess.ModeFlags.WRITE)
		new_file.store_buffer(existing)
		new_file.close()
		DirAccess.remove_absolute(LOGGER_PATH)
	file = FileAccess.open(LOGGER_PATH, FileAccess.ModeFlags.WRITE)

func _ready() -> void:
	OS.add_logger(CustomLogger.new("Godot"))

func write(entry: Entry) -> void:
	print(entry._to_string())
	file.store_line(entry._to_string())
	file.flush()
	
func trace(message: Variant) -> void:
	write(Entry.new(name, var_to_str(message), Entry.Level.TRACE))

func debug(message: Variant) -> void:
	write(Entry.new(name, var_to_str(message), Entry.Level.DEBUG))

func info(message: Variant) -> void:
	write(Entry.new(name, var_to_str(message), Entry.Level.INFO))

func warn(message: Variant) -> void:
	write(Entry.new(name, var_to_str(message), Entry.Level.WARN))

func error(message: Variant) -> void:
	write(Entry.new(name, var_to_str(message), Entry.Level.ERROR))

func _log_message(message: String, error: bool) -> void:
	if (error):
		error(message)
	else:
		info(message)

func _log_error(function: String, 
				file: String, 
				line: int, 
				code: String, 
				rationale: String, 
				editor_notify: bool, 
				error_type: int, 
				script_backtraces: Array[ScriptBacktrace]
			   ) -> void:
	error(function + ": " + rationale)



static func get_date_time_string() -> String:
	var t = Time.get_datetime_dict_from_system()
	return "%02d-%02d-%04d_%02d.%02d.%02d" % [t.month, t.day, t.year, t.hour, t.minute, t.second]

class Entry:
	var name: String
	var message: String
	var level: Level
	var timestamp: Dictionary

	func _init(name: String, message: String, level: Level) -> void:
		self.name = name
		self.message = message
		self.level = level
		timestamp = Time.get_datetime_dict_from_system()

	func _to_string() -> String:
		return "[%s] [%s/%s]: %s" % [get_time_string(), name, Level.keys()[level].to_upper(), message]

	func get_time_string() -> String:
		var t = Time.get_datetime_dict_from_system()
		return "%02d:%02d:%02d" % [t.hour, t.minute, t.second]

	enum Level {
		TRACE = 0,
		DEBUG = 1,
		INFO = 2,
		WARN = 3,
		ERROR = 4
	}
