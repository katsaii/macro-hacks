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