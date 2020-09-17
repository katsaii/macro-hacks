/* Pseudo Coroutines
 * -----------------
 * Kat @Katsaii
 */

#macro COROUTINE \
		static __coroutine_id = 0; \
		var __coroutine_current = 0; \
		__coroutine_id += 1; \
		for (;; { \
			__coroutined_id = 1; \
			__coroutine_current = 0; \
		}) if (__coroutine_id <= ++__coroutine_current)

#macro YIELD \
		; return; } else if (__coroutine_id <= ++__coroutine_current) {

#macro OTHERWISE else