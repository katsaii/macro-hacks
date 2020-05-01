/* Tests basic coroutine behaviour.
 * Kat @Katsaii
 */

randomise();

function test() {
	COROUTINE {
		return 1 YIELD;
		return 2 YIELD;
		return 3;
	} else {
		break;
	}
	return "final";
}

show_message(test());
show_message(test());
show_message(test());
show_message(test());
show_message(test());
show_message(test());