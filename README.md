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
```

Using the `COROUTINE` macro sets up the state of the function, then `YIELD` causes the function to temporarily halt. If the function is called again, processing will pick up where it left off.

```js
one_to_three(); // 1
one_to_three(); // 2
one_to_three(); // 3
one_to_three(); // 1
one_to_three(); // 2
// etc.
```
