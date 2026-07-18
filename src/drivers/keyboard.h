#ifndef __KEYBOARD_H__
#define __KEYBOARD_H__

#include <arch/x86/interrupts.h>
#include <arch/x86/port.h>
#include <common/types.h>
#include <drivers/driver.h>

class KeyboardEventHandler {
   public:
    KeyboardEventHandler();

    virtual void OnKeyDown(char);
    virtual void OnKeyUp(char);
};

class KeyboardDriver : public InterruptHandler, public Driver {
    Port8Bit dataport;
    Port8Bit commandport;

    KeyboardEventHandler* handler;

   public:
    KeyboardDriver(InterruptManager* manager, KeyboardEventHandler* handler);
    ~KeyboardDriver();
    virtual uint32_t HandleInterrupt(uint32_t esp);
    virtual void Activate();
};

#endif  // __KEYBOARD_H__
