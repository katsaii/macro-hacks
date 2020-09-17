# Properties

This is a proof-of-concept for a set of macros for [GameMaker Studio 2](https://www.yoyogames.com/gamemaker) that enable read-only, write-only, and get-set behaviour of properties, as seen in various Object Oriented (OO) languages.

## Usage examples

`GETTER` and `SETTER` are placeholder names that behave similarly to their OO counterparts:

```js
SETTER = 12;
show_message(GETTER); // prints: '12'
```

### Setting Invalid Values

Error messages can be configured to prevent invalid values from being assigned to the property:

```js
SETTER = 1.0;    // success
SETTER = "five"; // error
```

### Operators

This design also supports the ability to use assignment operators on the setter:

```js
SETTER = 2;      // value: 2
SETTER += 5;     // value: 7
```

### Getset

It may also be possible to create a getter-setter using the macro `#macro GETSET GETTER; SETTER`, with the limitation of not being able to use it 'inline':

```js
GETSET = 3;
show_message(GETSET);         // invalid token
```

This is because this segment of code will be transformed into

```js
GETTER; SETTER = 3;
show_message(GETTER; SETTER); // invalid token
```

by the compiler, and is clearly invalid code.