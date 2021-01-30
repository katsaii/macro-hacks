/* GUI Layer Extensions
 * --------------------
 * Kat @katsaii
 */

#macro __INTERNAL_DISPLAY_GET_GUI_WIDTH display_get_gui_width
#macro __INTERNAL_DISPLAY_GET_GUI_HEIGHT display_get_gui_height
#macro __INTERNAL_DISPLAY_SET_GUI_MAXIMISE display_set_gui_maximise
#macro __INTERNAL_DISPLAY_SET_GUI_SIZE display_set_gui_size
#macro display_get_gui_width __display_get_gui_width
#macro display_get_gui_height __display_get_gui_height
#macro display_set_gui_maximise __display_set_gui_maximise
#macro display_set_gui_size __display_set_gui_size

/// @desc Returns the static state of the GUI layer.
function __display_gui_config() {
	static config = {
		customSize : false,
		w : 0,
		h : 0
	};
	return config;
}

/// @desc Sets the position of the GUI layer to this rectangle.
/// @param {real} xscale The x scale of the layer.
/// @param {real} yscale The y scale of the layer.
/// @param {real} x1 The left position of the region.
/// @param {real} y1 The top position of the region.
/// @param {real} x2 The right position of the region.
/// @param {real} y2 The bottom position of the region.
function display_set_gui_position(_xscale, _yscale, _x1, _y1, _x2, _y2) {
	var config = __display_gui_config();
	config.customSize = true;
	config.w = (_x2 - _x1) / _xscale;
	config.h = (_y2 - _y1) / _yscale;
	__INTERNAL_DISPLAY_SET_GUI_MAXIMISE(_xscale, _yscale, _x1, _y1);
}

/// @desc Gets the width of the GUI layer.
function __display_get_gui_width() {
	var config = __display_gui_config();
	return config.customSize ? config.w : __INTERNAL_DISPLAY_GET_GUI_WIDTH();
}

/// @desc Gets the height of the GUI layer.
function __display_get_gui_height() {
	var config = __display_gui_config();
	return config.customSize ? config.h : __INTERNAL_DISPLAY_GET_GUI_HEIGHT();
}

/// @desc Sets the scale and offset of the GUI layer.
/// @param {real} xscale The x scale of the layer.
/// @param {real} yscale The y scale of the layer.
/// @param {real} xoff The x offset of the layer.
/// @param {real} yoff The y offset of the layer.
function __display_set_gui_maximise() {
	__display_gui_config().customSize = false;
	switch (argument_count) {
	case 2:
		__INTERNAL_DISPLAY_SET_GUI_MAXIMISE(argument[0], argument[1]);
		break;
	case 4:
		__INTERNAL_DISPLAY_SET_GUI_MAXIMISE(argument[0], argument[1], argument[2], argument[3]);
		break;
	default:
		__INTERNAL_DISPLAY_SET_GUI_MAXIMISE();
		break;
	}
}

/// @desc Sets the width and height of the GUI layer.
/// @param {real} width The width of the layer.
/// @param {real} height The height of the layer.
function __display_set_gui_size(_width, _height) {
	__display_gui_config().customSize = false;
	__INTERNAL_DISPLAY_SET_GUI_SIZE(_width, _height);
}