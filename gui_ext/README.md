# GUI Layer Fixes and Extensions

This script extends the built-in functionality of the GUI layer, allowing for GUIs with arbitrary width, height, and position.

## Minimal Working Example

To get started, include the `scr_application.gml` file into your project. This script comes packaged with only a single public function, `display_set_gui_position(xscale, yscale, x1, x1, x2, y2)`, which determines the scale of the GUI, and the region within the display to render the GUI at. For example, the following snippet will set the GUI to be equal to the size of the application surface, with a scale of 2:

```js
var boundary = application_get_position();
var left = boundary[0];
var top = boundary[1];
var right = boundary[2];
var bottom = boundary[3];
var scale = 2;
display_set_gui_position(scale, scale, left, top, right, bottom);
```