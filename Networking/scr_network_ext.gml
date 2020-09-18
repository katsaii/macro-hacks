/* Network Function Extension Functions
 * ------------------------------------
 * Kat @Katsaii
 */

#macro __NETWORK_SET_CONFIG network_set_config
#macro network_set_config __network_set_config

/// @desc Returns the global config for the clients.
function __network_config() {
	static config = {
		timeout : -1,
		nonblocking : false
	};
	return config;
}

/// @desc A wrapper for `network_set_config` that stores configurations in a global struct.
/// @param {value} config_value The config to update.
/// @param {value} setting The setting to assign.
function __network_set_config(_config_value, _setting) {
	var result = __NETWORK_SET_CONFIG(_config_value, _setting);
	var config = __network_config();
	switch (_config_value) {
	case network_config_connect_timeout:
		config.timeout = _setting;
		break;
	case network_config_use_non_blocking_socket:
		config.nonblocking = _setting;
		break;
	}
	return result;
}

/// @desc Returns the setting of this configuration value.
/// @param {value} config_value The config to check.
/// @param {value} [socket] For reliable UDP configurations.
function network_get_config(_config_value, _setting) {
	var result = undefined;
	var config = __network_config();
	switch (_config_value) {
	case network_config_connect_timeout:
		result = config.timeout;
		break;
	case network_config_use_non_blocking_socket:
		result = config.nonblocking;
		break;
	}
	return result;
}