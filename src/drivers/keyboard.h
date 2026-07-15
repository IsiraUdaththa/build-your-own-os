#ifndef __KEYBOARD_H__
#define __KEYBOARD_H__

#include <arch/x86/interrupts.h>
#include <arch/x86/port.h>
#include <common/types.h>

class KeyboardDriver : public InterruptHandler {
    Port8Bit dataport;
    Port8Bit commandport;

   public:
    KeyboardDriver(InterruptManager* manager);
    ~KeyboardDriver();
    virtual uint32_t HandleInterrupt(uint32_t esp);
};

#endif  // __KEYBOARD_H__
