
#macro YIELDABLE \
		static __yield_id = 0; \
		var __yield_current = 0; \
		__yield_id += 1; \
		for (;; { __yield_id = 1; __yield_current = 0; }) 

#macro YIELD \
		__yield_current += 1; \
		if (__yield_current == __yield_id) return

function my_func() {
	YIELDABLE {
		YIELD 1;
		if (choose(1, 2) == 1) {
			YIELD "A";
		}
		YIELD 2;
	}
}

randomise();

var a = my_func();
var b = my_func();
var c = my_func();
var d = my_func();
var e = my_func();
var f = my_func();
var g = my_func();
show_message([a, b, c, d, e, f, g]);