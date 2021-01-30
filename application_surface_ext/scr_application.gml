/* Application Surface Extensions
 * ------------------------------
 * Kat @katsaii
 */

#macro __APPLICATION_GET_POSITION application_get_position
#macro __APPLICATION_SURFACE_DRAW_ENABLE application_surface_draw_enable
#macro __WINDOW_VIEW_MOUSE_GET_X window_view_mouse_get_x
#macro __WINDOW_VIEW_MOUSE_GET_Y window_view_mouse_get_y
#macro __WINDOW_VIEWS_MOUSE_GET_X window_views_mouse_get_x
#macro __WINDOW_VIEWS_MOUSE_GET_Y window_views_mouse_get_y
#macro application_get_position __application_get_position
#macro application_surface_draw_enable __application_surface_draw_enable
#macro window_view_mouse_get_x __window_view_mouse_get_x
#macro window_view_mouse_get_y __window_view_mouse_get_y
#macro window_views_mouse_get_x __window_views_mouse_get_x
#macro window_views_mouse_get_y __window_views_mouse_get_y
#macro mouse_x (__window_views_mouse_get_x())
#macro mouse_y (__window_views_mouse_get_y())

/// @desc Returns the static state of the application surface.
function __application_surface_config() {
	static config = {
		drawEnabled : true,
		left : 0,
		top : 0,
		right : 0,
		bottom : 0,
		viewFocused : 0,
		viewCursors : array_create(2 * 8)
	};
	return config;
}

/// @desc Returns the static application surface information.
function __application_get_position() {
	var config = __application_surface_config();
	return config.drawEnabled ? __APPLICATION_GET_POSITION() : [config.left, config.top, config.right, config.bottom];
}

/// @desc Sets the position of the application surface.
/// @param {real} x1 The left position of the region.
/// @param {real} y1 The top position of the region.
/// @param {real} x2 The right position of the region.
/// @param {real} y2 The bottom position of the region.
function application_set_position(_x1, _y1, _x2, _y2) {
	var config = __application_surface_config();
	config.left = _x1;
	config.top = _y1;
	config.right = _x2;
	config.bottom = _y2;
}

/// @desc Sets the position of the application surface.
/// @param {real} x1 The left position of the region.
/// @param {real} y1 The top position of the region.
/// @param {real} x2 The right position of the region.
/// @param {real} y2 The bottom position of the region.
/// @param {real} frac Whether to allow fractional scale factors.
function application_set_position_fixed(_x1, _y1, _x2, _y2, _frac) {
	var app_width = surface_get_width(application_surface);
	var app_height = surface_get_height(application_surface);
	var scale_width = app_width == 0 ? infinity : (_x2 - _x1) / app_width;
	var scale_height = app_height == 0 ? infinity : (_y2 - _y1) / app_height;
	var scale = min(scale_width, scale_height);
	if not (_frac) {
		var mag = abs(scale);
		var signum = sign(scale);
		scale = signum * (mag < 1 ? 1 : floor(mag));
	}
	var centre_x = mean(_x1, _x2);
	var centre_y = mean(_y1, _y2);
	var fit_width = app_width * scale;
	var fit_height = app_height * scale;
	var fit_left = centre_x - fit_width div 2;
	var fit_top = centre_y - fit_height div 2;
	var fit_right = fit_left + fit_width;
	var fit_bottom = fit_top + fit_height;
	application_set_position(fit_left, fit_top, fit_right, fit_bottom);
}

/// @desc Enables/disables the application surface.
/// @param {bool} on_off Whether to enable the application surface.
function __application_surface_draw_enable(_enable) {
	var config = __application_surface_config();
	__APPLICATION_SURFACE_DRAW_ENABLE(_enable);
	if (config.drawEnabled && !_enable) {
		// this is used to update the custom position to the current application surface dimensions
		var pos = __APPLICATION_GET_POSITION();
		application_set_position(pos[0], pos[1], pos[2], pos[3]);
	}
	config.drawEnabled = _enable;
}

/// @desc Returns the total bounding box of all combined view ports.
function application_views_get_position() {
	var left = infinity;
	var top = infinity;
	var right = -infinity;
	var bottom = -infinity;
	for (var i = 7; i >= 0; i -= 1) {
		if not (view_visible[i]) {
			continue;
		}
		var ox = view_xport[i];
		var oy = view_yport[i];
		left = min(left, ox);
		top = min(top, oy);
		right = max(right, ox + view_wport[i]);
		bottom = max(bottom, oy + view_hport[i]);
	}
	return [left, top, right, bottom];
}

/// @desc Updates the mouse position of all visible view ports.
function application_views_mouse_update() {
	var config = __application_surface_config();
	var mx = window_mouse_get_x();
	var my = window_mouse_get_y();
	var app_pos = __application_get_position();
	mx -= app_pos[0];
	my -= app_pos[1];
	mx /= app_pos[2] - app_pos[0];
	my /= app_pos[3] - app_pos[1];
	var view_pos = application_views_get_position();
	mx = lerp(view_pos[0], view_pos[2], mx);
	my = lerp(view_pos[1], view_pos[3], my);
	config.viewFocused = 0;
	for (var i = 0; i <= 7; i += 1) {
		if not (view_visible[i]) {
			continue;
		}
		var view_mx = mx;
		var view_my = my;
		view_mx -= view_xport[i];
		view_my -= view_yport[i];
		view_mx /= view_wport[i];
		view_my /= view_hport[i];
		if (view_mx >= 0 && view_mx <= 1 &&
				view_my >= 0 && view_my <= 1) {
			config.viewFocused = i;
		}
		var cam = view_camera[i];
		var cam_left = camera_get_view_x(cam);
		var cam_top = camera_get_view_y(cam);
		var cam_right = cam_left + camera_get_view_width(cam);
		var cam_bottom = cam_top + camera_get_view_height(cam);
		view_mx = lerp(cam_left, cam_right, view_mx);
		view_my = lerp(cam_top, cam_bottom, view_my);
		config.viewCursors[@ 2 * i + 0] = floor(view_mx);
		config.viewCursors[@ 2 * i + 1] = floor(view_my);
	}
}

/// @desc Draws the application surface at the designated coordinates.
function application_surface_draw() {
	var pos = __application_get_position();
	var app_x = pos[0];
	var app_y = pos[1];
	var app_width = pos[2] - app_x;
	var app_height = pos[3] - app_y;
	draw_surface_stretched(application_surface, app_x, app_y, app_width, app_height);
}

/// @desc Returns the x position of the mouse.
/// @param {real} view The id of the view to check.
function __window_view_mouse_get_x(_view) {
	var config = __application_surface_config();
	return config.drawEnabled ? __WINDOW_VIEW_MOUSE_GET_X(_view) : config.viewCursors[2 * _view + 0];
}

/// @desc Returns the x position of the mouse.
/// @param {real} view The id of the view to check.
function __window_view_mouse_get_y(_view) {
	var config = __application_surface_config();
	return config.drawEnabled ? __WINDOW_VIEW_MOUSE_GET_Y(_view) : config.viewCursors[2 * _view + 1];
}

/// @desc Returns the x position of the mouse, respective to all views.
function __window_views_mouse_get_x() {
	var config = __application_surface_config();
	return config.drawEnabled ? __WINDOW_VIEWS_MOUSE_GET_X() : config.viewCursors[2 * config.viewFocused + 0];
}

/// @desc Returns the y position of the mouse, respective to all views.
function __window_views_mouse_get_y() {
	var config = __application_surface_config();
	return config.drawEnabled ? __WINDOW_VIEWS_MOUSE_GET_Y() : config.viewCursors[2 * config.viewFocused + 1];
}