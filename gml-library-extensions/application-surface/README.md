# Application Surface Fixes and Extensions

This script extends the built-in functionality of the application surface, allowing for the application surface to be moved at arbitrary positions and still respond correctly to mouse input.

## Minimal Working Example

To get started, include the `scr_application.gml` file into your project. Next, create an object called `obj_display` that will control the application surface. Make sure `obj_display` is marked as persistent and is included in the first room of your game. Next, include the following code snippets as part of their respective events:

### Create Event

```js
application_surface_draw_enable(false);
```

### Begin Step Event

```js
// this makes sure the mouse position relative to the
// new application surface position is updated correctly
application_views_mouse_update();
```

### Post Draw Event

```js
application_surface_draw();
```

## Resizing the Application Surface

Use the `application_set_position(x1, y1, x2, y2)` function to set the region where you want the application surface to be draw. If you want to maintain the aspect ratio, then use the `application_set_position_fixed(x1, y1, x2, y2, frac)` function instead.

The `frac` argument indicates whether fractional scale factors are allowed. If your game is pixel art and you don't want to stretch the pixels non-uniformly, then using `false` for this argument will make sure there is no distortion.