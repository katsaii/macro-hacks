/* Pseudo-coroutines (See: `https://github.com/NuxiiGit/gml-yield`)
 * Kat @Katsaii
 */

#macro COROUTINE \
		static __yield_id = 0; \
		var __yield_current = 0; \
		__yield_id += 1; \
		for (;; { __yield_id = 1; __yield_current = 0; }) if (__yield_id <= ++__yield_current)

#macro YIELD \
		; return; } else if (__yield_id <= ++__yield_current) {

#macro OTHERWISE else