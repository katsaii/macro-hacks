# Foreach

This short set of macros help enable "for each" loops for arrays in [GameMaker Studio 2](https://www.yoyogames.com/gamemaker).

## Usage example

This extension is syntactically similar to most programming language "for each" loops, with the exception of an additional (required) `DO` keyword at the end:

```js
var msg = "";
FOREACH number IN [1, 2, 3, 4, 5] DO {
  msg += "she said '" + string(number) + "'\n";
}
show_message(msg); // she said '1'
                   // she said '2'
                   // she said '3'
                   // she said '4'
                   // she said '5'
```