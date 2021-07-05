# GUI Layer Fixes and Extensions

This script makes it possible for dynamic data structures to be automatically marked and garbage collected within a workspace.

## Minimal Working Example

Use `workspace_begin` to start the workspace, and `workspace_end` to collect any leaked memory.

```js
// start the workspace
workspace_begin();

// create some garbage
ds_list_create();
ds_map_create();
ds_stack_create();
var queue = ds_queue_create();
ds_queue_destroy(queue);

// finalise the workspace
workspace_end();
```
