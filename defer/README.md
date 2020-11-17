# Defer

This short set of macros help enable deferred execution of code for [GameMaker Studio 2](https://www.yoyogames.com/gamemaker).

## Usage examples

This works similar to `defer` in languages such as Go or Zig; execution of the block between the macros `DEFER` and `UNTIL` is deferred until the block after `UNTIL` is complete.

### Data Structures

Destroying a list after three elements are added
```js
var list = ds_list_create();
DEFER {
  ds_list_destroy(list);
} UNTIL {
  ds_list_add(list, 1);
  ds_list_add(list, 2);
  ds_list_add(list, 3);
}
```

### File Handling

Closing a text file after its content is read
```js
var file = file_text_open_read("test.txt");
var msg = "";
DEFER file_text_close(file) UNTIL {
  while (!file_text_eof(file)) {
    msg += file_text_readln(file);
  }
}
```
