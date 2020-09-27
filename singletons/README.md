# Singletons

This combination of macros and functions enables developers to create runtime-safe singletons, system objects, and parent objects.

## Discovering Singletons

This library discovers special instances using resource name prefixes. Singleton resources should be prefixed with `the_`, for example: `the_camera`. Similarly, system and parent objects should be prefixed with `sys_` and `par_`: `sys_inventory` or `par_platform` are valid examples of system (`sys`) and parent (`par`) objects.