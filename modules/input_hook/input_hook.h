#ifndef INPUT_HOOK_H
#define INPUT_HOOK_H

#include "core/reference.h"

class InputHook : public Reference {
    GDCLASS(InputHook, Reference);

    int count;

protected:
    static void _bind_methods();

public:
    void add(int p_value);
    void reset();
    int get_total() const;

    InputHook();
};

#endif // SUMMATOR_H