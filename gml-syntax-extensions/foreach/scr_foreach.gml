/* Array Foreach Loop
 * ------------------
 * Kat @katsaii
 */

#macro FOREACH \
		var __foreach_init = true; \
		var __foreach_items; \
		var __foreach_i = -1; \
		var __foreach_n = infinity; \
		for (;; { \
			__foreach_i += 1; \
			if (__foreach_i >= __foreach_n) { \
				break; \
			} \
			var

#macro IN \
			= __foreach_items[__foreach_i]; \
		}) if (__foreach_init) { \
			__foreach_init = false; \
			__foreach_items =

#macro DO \
			; \
			__foreach_n = array_length(__foreach_items); \
		} else