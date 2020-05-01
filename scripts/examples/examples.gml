/* Tests basic coroutine behaviour
 * Kat @Katsaii
 */

function generator() {
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

show_message([
		generator(),
		generator(),
		generator(),
		generator(),
		generator()]);