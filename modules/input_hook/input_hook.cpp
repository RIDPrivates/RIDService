#include "input_hook.h"

void InputHook::add(int p_value) {
    count += p_value;
}

void InputHook::reset() {
    count = 0;
}

int InputHook::get_total() const {
    return count;
}

void InputHook::_bind_methods() {
    ClassDB::bind_method(D_METHOD("add", "value"), &Summator::add);
    ClassDB::bind_method(D_METHOD("reset"), &Summator::reset);
    ClassDB::bind_method(D_METHOD("get_total"), &Summator::get_total);
}

InputHook::InputHook() {
    count = 0;
}