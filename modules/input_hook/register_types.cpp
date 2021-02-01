#include "register_types.h"

#include "core/class_db.h"
#include "input_hook.h"

void register_input_hook_types() {
    ClassDB::register_class<Summator>();
}

void unregister_input_hook_types() {
   // Nothing to do here in this example.
}