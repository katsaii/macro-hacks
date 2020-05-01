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
