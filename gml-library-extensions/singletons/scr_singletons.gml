/* System Object Utilities
 * -----------------------
 * Kat @katsaii
 */

#macro __CONTROLLER_INSTANCE_CREATE_DEPTH instance_create_depth
#macro __CONTROLLER_INSTANCE_CREATE_LAYER instance_create_layer
#macro __CONTROLLER_INSTANCE_DEACTIVATE_ALL instance_deactivate_all
#macro __CONTROLLER_INSTANCE_DEACTIVATE_OBJECT instance_deactivate_object
#macro __CONTROLLER_INSTANCE_DEACTIVATE_REGION instance_deactivate_region
#macro __CONTROLLER_INSTANCE_DEACTIVATE_LAYER instance_deactivate_layer
#macro __CONTROLLER_INSTANCE_COPY instance_copy
#macro __CONTROLLER_INSTANCE_DESTROY instance_destroy
#macro instance_create_depth controller_instance_create_depth
#macro instance_create_layer controller_instance_create_layer
#macro instance_deactivate_all controller_instance_deactivate_all
#macro instance_deactivate_object controller_instance_deactivate_object
#macro instance_deactivate_region controller_instance_deactivate_region
#macro instance_deactivate_layer controller_instance_deactivate_layer
#macro instance_copy controller_instance_copy
#macro instance_destroy controller_instance_destroy

/// @desc Returns the prefixes of every object.
function object_prefixes() {
	static prefixes = (function() {
		var array = [];
		for (var i = 0; object_exists(i); i += 1) {
			var name = object_get_name(i);
			var pos = string_pos("_", name);
			var prefix = pos == -1 ? name : string_copy(name, 1, pos - 1);
			array_resize(array, i + 1);
			array[@ i] = prefix;
		}
		return array;
	})();
	return prefixes;
}

/// @desc Returns whether an object is a singleton.
/// @param {real} obj The object index to check.
function object_is_singleton(_obj) {
	var prefix = object_prefixes()[_obj];
	return prefix == "the";
}

/// @desc Returns whether an object is abstract.
/// @param {real} obj The object index to check.
function object_is_abstract(_obj) {
	var prefix = object_prefixes()[_obj];
	return prefix == "par";
}

/// @desc Returns whether an object is a controller/system object.
/// @param {real} obj The object index to check.
function object_is_system(_obj) {
	var prefix = object_prefixes()[_obj];
	return prefix == "sys";
}

/// @desc Returns a diagnostic messages for this object, depending on whether a new instance can be created.
/// @param {real} obj The object index to check.
function controller_object_get_diagnostic(_obj) {
	if (object_is_singleton(_obj) && instance_exists(_obj)) {
		return "multiple singletons of the same kind (" + object_get_name(_obj) + ") cannot exist at the same time";
	}
	if (object_is_abstract(_obj)) {
		return "abstract objects (" + object_get_name(_obj) + ") are not allowed to be constructed";
	}
	return undefined;
}

/// @desc Wrapper for `instance_create_depth` which checks whether the instance is able to be safely created.
/// @param {real} x The x position.
/// @param {real} y The y position.
/// @param {real} depth The depth to create the instance at.
/// @param {real} obj The object index to create an instance of.
function controller_instance_create_depth(_x, _y, _depth, _obj) {
	var error = controller_object_get_diagnostic(_obj);
	if (error != undefined) {
		show_error(error, false);
		return noone;
	}
	return __CONTROLLER_INSTANCE_CREATE_DEPTH(_x, _y, _depth, _obj);
}

/// @desc Wrapper for `instance_create_layer` which checks whether the instance is able to be safely created.
/// @param {real} x The x position.
/// @param {real} y The y position.
/// @param {real} layer_name_or_id The layer to create the instance on.
/// @param {real} obj The object index to create an instance of.
function controller_instance_create_layer(_x, _y, _layer, _obj) {
	var error = controller_object_get_diagnostic(_obj);
	if (error != undefined) {
		show_error(error, false);
		return noone;
	}
	return __CONTROLLER_INSTANCE_CREATE_LAYER(_x, _y, _layer, _obj);
}

/// @desc Wrapper for `instance_deactivate_all` which does not deactivate singleton objects.
function controller_instance_deactivate_all() {
	with (all) {
		if (object_is_singleton(object_index) || object_is_system(object_index)) {
			continue;
		}
		__CONTROLLER_INSTANCE_DEACTIVATE_OBJECT(id);
	}
}

/// @desc Wrapper for `instance_deactivate_object` which does not deactivate singleton objects.
/// @param {real} obj The id of the instance or object to deactivate.
function controller_instance_deactivate_object(_inst) {
	var obj = instance_exists(_inst) ? _inst.object_index : _inst;
	if (object_is_singleton(obj) || object_is_system(obj)) {
		show_error("singleton and system objects (" + object_get_name(obj) + ") are not allowed to be deactivated", false);
	} else {
		__CONTROLLER_INSTANCE_DEACTIVATE_OBJECT(_inst);
	}
}

/// @desc Wrapper for `instance_deactivate_region` which does not deactivate singleton objects.
/// @param {real} left The left position of the region.
/// @param {real} top The top position of the region.
/// @param {real} width The width of the region.
/// @param {real} height The height of the region.
/// @param {bool} inside Whether to deactivate instances inside the region.
/// @param {bool} notme Whether to ignore the current instance.
function controller_instance_deactivate_region(_left, _top, _width, _height, _inside, _notme) {
	var me = id;
	with (all) {
		if (_notme && me == id || object_is_singleton(object_index) || object_is_system(object_index)) {
			continue;
		}
		var collision = collision_rectangle(_left, _top, _left + _width, _top + _height, id, true, false);
		if not (_inside ^^ collision) {
			__CONTROLLER_INSTANCE_DEACTIVATE_OBJECT(id);
		}
	}
}

/// @desc Wrapper for `instance_deactivate_layer` which does not deactivate singleton objects.
/// @param {real} layer_name_or_id The id of the layer to deactivate instances of.
function controller_instance_deactivate_layer(_layer) {
	var layer_target = is_string(_layer) ? layer_get_id(_layer) : _layer;
	with (all) {
		if (object_is_singleton(object_index) || object_is_system(object_index)) {
			continue;
		}
		var layer_current = is_string(layer) ? layer_get_id(layer) : layer;
		if (layer_current == layer_target) {
			__CONTROLLER_INSTANCE_DEACTIVATE_OBJECT(id);
		}
	}
}

/// @desc Wrapper for `instance_copy` which checks whether the instance is able to be safely copied.
/// @param {bool} performevent Whether to perform instance creation code.
function controller_instance_copy(_perf) {
	var error = controller_object_get_diagnostic(object_index);
	if (error != undefined) {
		show_error(error, false);
		return noone;
	}
	return __CONTROLLER_INSTANCE_COPY(_perf);
}

/// @desc Wrapper for `controller_instance_destroy` which checks whether the instance is able to be safely destroyed.
/// @param {real} [id] The id of the instance to destroy.
/// @param {bool} [performevent] Whether to perform the instance destroy code.
function controller_instance_destroy() {
	var inst = argument_count > 0 ? argument[0] : id;
	var perf = argument_count > 1 && argument[1];
	var obj = instance_exists(inst) ? inst.object_index : inst;
	if (object_is_singleton(obj)) {
		show_error("singleton objects (" + object_get_name(obj) + ") should not be destroyed", false);
		return;
	}
	__CONTROLLER_INSTANCE_DESTROY(inst, perf);
}

for (var i = 0; object_exists(i); i += 1) {
	if (object_is_singleton(i) || object_is_system(i)) {
		if (object_is_singleton(i)) {
			room_instance_add(room_first, 0, 0, i);
		}
		object_set_persistent(i, true);
	}
}