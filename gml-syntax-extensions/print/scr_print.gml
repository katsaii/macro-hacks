/* Print Statement
 * ---------------
 * Kat @katsaii
 */

#macro PRINT \
    for (var print_value;; { \
      show_debug_message(print_value); \
      break; \
    }) print_value =