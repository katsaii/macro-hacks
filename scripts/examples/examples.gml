/* Tests basic coroutine behaviour
 * Kat @Katsaii
 */

function basic_generator() {
	COROUTINE {
		return 1;
		YIELD;
		return 2;
		YIELD;
		return 3;
	} OTHERWISE {
		break;
	}
	return "final";
}
basic_generator(); // 1
basic_generator(); // 2
basic_generator(); // 3
basic_generator(); // "final"
basic_generator(); // "final"
// etc.

function one_to_three() {
	COROUTINE {
		return 1;
		YIELD;
		return 2;
		YIELD;
		return 3;
	}
}
one_to_three(); // 1
one_to_three(); // 2
one_to_three(); // 3
one_to_three(); // 1
one_to_three(); // 2
// etc.

function only_two() {
	COROUTINE {
		break;
		YIELD;
		return 2;
		YIELD;
		break;
	}
	return "nothing";
}
only_two(); // "nothing"
only_two(); // 2
only_two(); // "nothing"
only_two(); // "nothing"
only_two(); // 2
// etc.

function abc_stream() {
	COROUTINE {
		return "A";
		YIELD;
		return "B";
		YIELD;
		return "C";
	} OTHERWISE {
		return undefined;
	}
}
abc_stream(); // "A"
abc_stream(); // "B"
abc_stream(); // "C"
abc_stream(); // undefined
abc_stream(); // undefined
abc_stream(); // undefined
abc_stream(); // undefined
// etc.