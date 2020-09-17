# gml-yield

This repository contains the sorce code for `gml-yield`, a short set of macros which enable coroutine-like behaviour for [GameMaker Studio 2](https://www.yoyogames.com/gamemaker).

## Usage examples

These macros can be used to create generator functions which return different things depending on some internal state. For example, returning numbers 1 to 3 in sequence:

```js
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
```

Using the `COROUTINE` macro sets up the state of the function, then `YIELD` causes the function to temporarily halt. If the function is called again, processing will pick up where it left off.

### Escaping the Coroutine Scope

If you decide you don't want to be inside the scope of the coroutine anymore, you can simply use the `break` keyword:

```js
function only_two() {
	COROUTINE {
		break;
		YIELD;
		return 2;
		YIELD;
		break;
	}
	// default
	return "nothing";
}

only_two(); // "nothing"
only_two(); // 2
only_two(); // "nothing"
only_two(); // "nothing"
only_two(); // 2
// etc.
```

### Reaching the End

There is a feature which allows you to run a block of code once the coroutine has ended. This can be used to throw errors, reset variables used in the coroutine, or to stop the coroutine entirely.

```js
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
```

The generator `abc_stream` produces its first three values, and then it never returns anything else.