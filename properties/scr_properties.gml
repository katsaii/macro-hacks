/* Pseudo Properties Proof of Concept
 * ----------------------------------
 * Kat @Katsaii
 */

#macro VAR "foo"

#macro GETTER variable_global_get(VAR)

#macro SETTER \ 
        for (var __value = GETTER;; { \ 
            if (is_real(__value) && __value > 0) { \ 
                variable_global_set(VAR, __value); \ 
            } else { \ 
                show_error("Global property '" + VAR + "' must be a positive number", false); \ 
            } \ 
            break; \
        }) __value